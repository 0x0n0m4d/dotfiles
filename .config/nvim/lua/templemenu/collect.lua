-- Step 1: gather the identifiers used in a buffer.
-- Treesitter when a parser exists (it knows identifiers from comments/strings),
-- otherwise a plain word scan. The LSP is the real filter afterwards: words
-- that are not definable (keywords, prose in comments) simply resolve to nothing.

local M = {}

-- Generic across grammars: leaf nodes whose type looks like a name.
local function is_ident(t)
  t = t:lower()
  return t:find("identifier", 1, true) ~= nil
    or t == "name" or t:find("_name$") ~= nil
    or t == "variable" or t == "constant" or t == "constructor"
end

local function from_treesitter(buf, occ)
  local ok, parser = pcall(vim.treesitter.get_parser, buf, nil, { error = false })
  if not ok or not parser then return false end
  if not pcall(parser.parse, parser, true) then return false end -- whole buffer, injections too

  local seen = {}
  parser:for_each_tree(function(tree)
    local stack = { tree:root() }
    while #stack > 0 do
      local node = table.remove(stack)
      if node:child_count() == 0 then
        if node:named() and is_ident(node:type()) then
          local row, col = node:range()
          local key = row .. ":" .. col
          if not seen[key] then
            seen[key] = true
            occ[#occ + 1] = { name = vim.treesitter.get_node_text(node, buf), row = row, col = col }
          end
        end
      else
        for child in node:iter_children() do stack[#stack + 1] = child end
      end
    end
  end)
  return true
end

local function from_words(buf, occ)
  for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for s, w in line:gmatch("()([%a_][%w_]*)") do
      occ[#occ + 1] = { name = w, row = i - 1, col = s - 1 }
    end
  end
end

local function by_position(a, b)
  if a.row ~= b.row then return a.row < b.row end
  return a.col < b.col
end

--- Returns occurrences { name, row, col } (0-based), in file order, one per
--- name unless cfg.per_occurrence is set.
function M.collect(buf, cfg)
  local occ = {}
  if not from_treesitter(buf, occ) or #occ == 0 then
    occ = {}
    from_words(buf, occ)
  end
  table.sort(occ, by_position)

  local out, seen = {}, {}
  for _, o in ipairs(occ) do
    if #o.name >= cfg.min_len and (cfg.per_occurrence or not seen[o.name]) then
      seen[o.name] = true
      out[#out + 1] = o
      if #out >= cfg.max_names then break end
    end
  end
  return out
end

return M
