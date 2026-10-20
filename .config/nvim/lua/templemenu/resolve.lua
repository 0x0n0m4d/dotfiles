-- Step 2: ask the LSP where each collected name is defined.
-- Asynchronous and bounded: at most cfg.concurrency requests in flight, rows
-- appear as answers arrive. A name whose definition is in THIS file is a local
-- and is dropped; the same definition is never listed twice.

local M = {}

local function norm(uri)
  if uri:sub(1, 5) == "file:" then return vim.uri_to_fname(uri) end
  return uri
end

-- byte column -> the encoding the server speaks (only matters for non-ASCII lines)
local function position(buf, row, col, enc)
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
  if col > 0 and line:find("[\128-\255]") then
    local ok, idx = pcall(vim.str_utfindex, line, enc, col, false)
    if ok and idx then col = idx end
  end
  return { line = row, character = col }
end

-- Location | Location[] | LocationLink[] | null  ->  { {uri, range}, ... }
local function locations(result)
  if not result then return {} end
  if result.uri or result.targetUri then result = { result } end
  local out = {}
  for _, l in ipairs(result) do
    local uri = l.uri or l.targetUri
    local range = l.range or l.targetSelectionRange or l.targetRange
    if uri and range then out[#out + 1] = { uri = uri, range = range } end
  end
  return out
end

--- Returns a session: { items, total, done, no_lsp, dirty, stop() }.
--- on_update() is called (from the main loop) whenever the session changes.
function M.start(buf, occurrences, cfg, on_update)
  local s = { items = {}, total = #occurrences, done = 0, dirty = false, inflight = {}, stopped = false }
  s.stop = function() end

  local client = vim.lsp.get_clients({ bufnr = buf, method = "textDocument/definition" })[1]
  if not client then
    s.no_lsp = true
    return s
  end

  local enc = client.offset_encoding
  local uri = vim.uri_from_bufnr(buf)
  local self_path = norm(uri)
  local seen = {}
  local next_i, running = 0, 0

  local function add(occ, ord, result)
    local fresh = {}
    for _, l in ipairs(locations(result)) do
      local path = norm(l.uri)
      if path ~= self_path then -- definitions inside this file are locals
        local key = occ.name .. "\0" .. path .. ":" .. l.range.start.line
        if not seen[key] then
          seen[key] = true
          fresh[#fresh + 1] = { path = path, loc = l }
        end
      end
    end
    for i, f in ipairs(fresh) do
      local label = occ.name
      if #fresh > 1 then -- one name, several definitions: tell them apart by file
        label = label .. "  " .. vim.fn.fnamemodify(f.path, ":t")
      end
      s.items[#s.items + 1] = {
        label = label, low = label:lower(), name = occ.name,
        loc = f.loc, enc = enc, ord = ord * 1000 + i,
      }
      s.dirty = true
    end
  end

  local pump
  pump = function()
    while not s.stopped and running < cfg.concurrency and next_i < #occurrences do
      next_i = next_i + 1
      local ord, occ = next_i, occurrences[next_i]
      local params = {
        textDocument = { uri = uri },
        position = position(buf, occ.row, occ.col, enc),
      }
      running = running + 1
      local rid
      local ok
      ok, rid = client:request("textDocument/definition", params, function(err, result)
        running = running - 1
        if rid then s.inflight[rid] = nil end
        if s.stopped then return end
        s.done = s.done + 1
        if not err then add(occ, ord, result) end
        on_update()
        pump()
      end, buf)
      if ok and rid then
        s.inflight[rid] = true
      else
        running = running - 1
        s.done = s.done + 1
      end
    end
  end

  s.stop = function()
    s.stopped = true
    for rid in pairs(s.inflight) do
      pcall(function() client:cancel_request(rid) end)
    end
    s.inflight = {}
  end

  pump()
  return s
end

return M
