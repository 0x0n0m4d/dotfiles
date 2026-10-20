-- Step 3: open a definition in a bottom window, read-only.
-- The same bottom window is reused between jumps, so they do not pile up.

local M = {}

function M.open(item, cfg, src_win)
  if src_win and vim.api.nvim_win_is_valid(src_win) then
    vim.api.nvim_set_current_win(src_win)
  end

  local win = M.win
  if win and vim.api.nvim_win_is_valid(win) and win ~= src_win then
    vim.api.nvim_set_current_win(win)
  else
    local h = math.max(3, math.floor((vim.o.lines - vim.o.cmdheight) * cfg.height_ratio))
    vim.cmd(("botright %dsplit"):format(h))
    win = vim.api.nvim_get_current_win()
    M.win = win
  end

  local ok = vim.lsp.util.show_document(item.loc, item.enc, { reuse_win = false, focus = true })
  if not ok then
    vim.notify("templemenu: could not open the definition of " .. item.name, vim.log.levels.WARN)
    return
  end

  -- Only touch the buffer once we know the window really shows the definition.
  local buf = vim.api.nvim_win_get_buf(win)
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true
  vim.api.nvim_win_call(win, function() vim.cmd("normal! zz") end)
end

return M
