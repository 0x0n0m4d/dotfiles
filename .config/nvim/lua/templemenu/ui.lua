-- The box: a floating window at the top-right, frame drawn by hand so MENU can
-- blink on the left edge and "+N [x]" can sit on the right edge.

local collect = require("templemenu.collect")
local resolve = require("templemenu.resolve")
local jump = require("templemenu.jump")

local M = {}
local S -- state of the open menu; nil while closed
local ns = vim.api.nvim_create_namespace("templemenu")

-- ------------------------------------------------------------ text helpers

local function strw(s) return vim.api.nvim_strwidth(s) end

local function clip(s, n)
  n = math.max(n, 0)
  while strw(s) > n do
    s = vim.fn.strcharpart(s, 0, vim.fn.strchars(s) - 1)
  end
  return s
end

local function fit(s, n)
  s = clip(s, n)
  return s .. string.rep(" ", math.max(n, 0) - strw(s))
end

local function new_line() return { text = "", spans = {} } end

local function put(line, text, hl)
  if hl then table.insert(line.spans, { #line.text, #line.text + #text, hl }) end
  line.text = line.text .. text -- spans are BYTE columns
end

-- ---------------------------------------------------------------- rendering

local function render()
  if not S or S.closed then return end
  local cfg, ses = S.cfg, S.session

  if ses.dirty then -- rows stay in file order, whatever order the LSP answers in
    table.sort(ses.items, function(a, b) return a.ord < b.ord end)
    ses.dirty = false
  end

  local q = S.flt:lower()
  local matches = ses.items
  if q ~= "" then
    matches = {}
    for _, it in ipairs(ses.items) do
      if it.low:find(q, 1, true) then matches[#matches + 1] = it end
    end
  end
  S.matches = matches

  -- height follows the TOTAL, not the filtered count, so it never jumps while typing
  local vis = math.max(1, math.min(#ses.items, cfg.max_visible, #cfg.keys, vim.o.lines - 8))
  S.vis = vis
  S.top = math.max(0, math.min(S.top, math.max(#matches - vis, 0)))

  local W = S.W
  local inner = W - 2
  local lines = {}

  -- top bar: blinking MENU on the left edge, +N and [x] on the right edge
  local count, closer = "+" .. #matches, "[x]"
  local l = new_line()
  put(l, "╔")
  put(l, "MENU", S.blink and "TempleMenuBlink" or nil)
  put(l, string.rep("═", math.max(inner - 4 - #count - #closer, 0)))
  put(l, count, "TempleMenuCount")
  put(l, closer)
  put(l, "╗")
  lines[#lines + 1] = l

  -- title row: title (and progress) on the left, the filter input on the right
  local status = ""
  if ses.no_lsp then
    status = " · no lsp"
  elseif ses.done < ses.total then
    status = (" %d/%d"):format(ses.done, ses.total)
  end
  local title = clip(" jump" .. status, inner - 4)
  local avail = math.max(inner - strw(title) - 1, 1)
  local inp = S.flt .. "_"
  if #inp > avail then inp = inp:sub(-avail) end
  l = new_line()
  put(l, "║")
  put(l, title, "TempleMenuTitle")
  put(l, string.rep(" ", math.max(inner - strw(title) - #inp - 1, 0)))
  put(l, inp, "TempleMenuTitle")
  put(l, " ")
  put(l, "║")
  lines[#lines + 1] = l

  -- rows: each ctrl key belongs to the ROW, not to the item
  local rw = W - 12
  for n = 1, vis do
    local row = new_line()
    put(row, "║")
    local it = matches[S.top + n]
    if it then
      put(row, " ")
      put(row, "'ctrl+" .. cfg.keys:sub(n, n) .. "'", "TempleMenuKey")
      put(row, " ")
      local name = clip(it.label, rw)
      local i = q ~= "" and name:lower():find(q, 1, true) or nil
      if i then
        put(row, name:sub(1, i - 1))
        put(row, name:sub(i, i + #q - 1), "TempleMenuHit")
        put(row, name:sub(i + #q))
      else
        put(row, name)
      end
      put(row, string.rep(" ", rw - strw(name)))
    else
      local msg = ""
      if n == 1 then
        if ses.no_lsp then msg = " no LSP client is attached to this buffer"
        elseif ses.done < ses.total then msg = " resolving..."
        else msg = " (none)" end
      end
      put(row, fit(msg, inner))
    end
    put(row, "║")
    lines[#lines + 1] = row
  end

  -- bottom bar: page keys on the right edge, only if there is more than a page
  local pager = #matches > vis and "ctrl+u/d" or ""
  l = new_line()
  put(l, "╚")
  put(l, string.rep("═", inner - #pager))
  put(l, pager)
  put(l, "╝")
  lines[#lines + 1] = l

  local text = {}
  for i, ln in ipairs(lines) do text[i] = ln.text end
  vim.bo[S.buf].modifiable = true
  vim.api.nvim_buf_set_lines(S.buf, 0, -1, false, text)
  vim.bo[S.buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(S.buf, ns, 0, -1)
  for i, ln in ipairs(lines) do
    for _, sp in ipairs(ln.spans) do
      vim.api.nvim_buf_set_extmark(S.buf, ns, i - 1, sp[1], { end_col = sp[2], hl_group = sp[3] })
    end
  end

  if S.height ~= vis + 3 then
    S.height = vis + 3
    vim.api.nvim_win_set_config(S.win, {
      relative = "editor", row = S.row, col = S.col, width = W, height = S.height,
    })
  end

  -- TempleOS style: the real cursor sits on the bottom-left corner of the box
  pcall(vim.api.nvim_win_set_cursor, S.win, { #lines, 0 })
  vim.api.nvim_win_call(S.win, function() vim.fn.winrestview({ topline = 1 }) end)
end

local function request_render() -- LSP answers arrive in bursts: coalesce them
  if not S or S.render_pending then return end
  S.render_pending = true
  vim.defer_fn(function()
    if S then S.render_pending = false end
    render()
  end, 40)
end

-- ----------------------------------------------------------------- closing

function M.close()
  if not S or S.closed then return end
  local st = S
  st.closed = true
  S = nil
  if st.timer then st.timer:stop(); st.timer:close() end
  st.session.stop()
  pcall(vim.api.nvim_del_augroup_by_id, st.aug)
  if vim.api.nvim_win_is_valid(st.win) then vim.api.nvim_win_close(st.win, true) end
  if vim.api.nvim_buf_is_valid(st.buf) then vim.api.nvim_buf_delete(st.buf, { force = true }) end
  if vim.api.nvim_win_is_valid(st.src_win) then vim.api.nvim_set_current_win(st.src_win) end
end

local function select(n)
  local item = S and S.matches[S.top + n]
  if not item then return end
  local cfg, src_win = S.cfg, S.src_win
  M.close()
  vim.schedule(function() jump.open(item, cfg, src_win) end)
end

-- -------------------------------------------------------------------- open

local function tabline_visible()
  return vim.o.showtabline == 2
    or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
end

function M.open(cfg)
  if S then return M.close() end

  local src_buf = vim.api.nvim_get_current_buf()
  local src_win = vim.api.nvim_get_current_win()
  local W = math.max(24, math.min(cfg.width, vim.o.columns - 2))

  S = {
    cfg = cfg, src_win = src_win, flt = "", top = 0, blink = false,
    W = W, matches = {}, vis = 1,
    row = tabline_visible() and 1 or 0, col = vim.o.columns - W,
  }
  S.session = resolve.start(src_buf, collect.collect(src_buf, cfg), cfg, request_render)

  S.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[S.buf].bufhidden = "wipe"
  S.win = vim.api.nvim_open_win(S.buf, true, {
    relative = "editor", row = S.row, col = S.col, width = W, height = 4,
    style = "minimal", border = "none", zindex = 200,
  })
  vim.wo[S.win].winhighlight = "Normal:TempleMenuBase,NormalFloat:TempleMenuBase"
  S.height = 4

  -- keys: every printable character goes into the filter (buffer-local, so
  -- nothing here can collide with your own mappings)
  local function map(lhs, fn)
    vim.keymap.set("n", lhs, fn, { buffer = S.buf, nowait = true, silent = true })
  end
  local special = { [" "] = "<Space>", ["|"] = "<Bar>", ["<"] = "<lt>" }
  for c = 32, 126 do
    local ch = string.char(c)
    map(special[ch] or ch, function()
      S.flt = S.flt .. ch; S.top = 0; render()
    end)
  end
  local function backspace()
    S.flt = S.flt:sub(1, -2); S.top = 0; render()
  end
  map("<BS>", backspace)
  map("<C-h>", backspace)
  map("<Esc>", M.close)
  map("<C-c>", M.close)
  map("<C-d>", function() S.top = math.min(S.top + S.vis, math.max(#S.matches - S.vis, 0)); render() end)
  map("<C-u>", function() S.top = math.max(S.top - S.vis, 0); render() end)
  for n = 1, #cfg.keys do
    map("<C-" .. cfg.keys:sub(n, n) .. ">", function() select(n) end)
  end

  S.aug = vim.api.nvim_create_augroup("templemenu_open", { clear = true })
  vim.api.nvim_create_autocmd("WinLeave", {
    group = S.aug, buffer = S.buf,
    callback = function() vim.schedule(M.close) end,
  })

  S.timer = vim.uv.new_timer()
  S.timer:start(cfg.blink_ms, cfg.blink_ms, vim.schedule_wrap(function()
    if S then S.blink = not S.blink; render() end
  end))

  render()
end

return M
