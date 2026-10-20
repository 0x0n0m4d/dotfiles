-- templemenu: a TempleOS-style jump menu.
-- Lists the names USED in the current buffer that are defined somewhere else
-- (other files, packages, the standard library), asks the LSP where they are
-- defined, and opens the definition read-only in a bottom window.

local M = {}

M.config = {
  key = "<leader>m",
  width = 44,            -- box width in columns
  max_visible = 14,      -- rows per page (never more than #keys)
  blink_ms = 200,        -- MENU blink phase, same as the kitty tab bar
  height_ratio = 0.65,   -- height of the bottom window
  concurrency = 8,       -- definition requests in flight at once
  max_names = 2000,      -- safety cap on requests per menu
  min_len = 2,           -- ignore 1-letter names (almost always locals)
  per_occurrence = false, -- true: ask for every use of a name, not just the first
  -- ctrl+<key> opens a row. Left out: c/d/u (close/page) and h/i/j/m, because
  -- terminals send the same byte for them as Backspace/Tab/Enter.
  keys = "asfgewrtyopzxvbnlk",
  -- defaults follow gruvbox ANSI colors; change them to match your terminal
  colors = {
    yellow = "#d79921", base = "#504945", green = "#98971a",
    magenta = "#d3869b", red = "#fb4934",
  },
}

function M.define_highlights()
  local c = M.config.colors
  local function hl(name, spec) vim.api.nvim_set_hl(0, name, spec) end
  hl("TempleMenuBase",  { fg = c.yellow,  bg = c.base,   ctermfg = 3,  ctermbg = 8 })
  hl("TempleMenuKey",   { fg = c.green,   bg = c.base,   ctermfg = 2,  ctermbg = 8 })
  hl("TempleMenuTitle", { fg = c.magenta, bg = c.base,   ctermfg = 13, ctermbg = 8 })
  hl("TempleMenuHit",   { fg = c.red,     bg = c.base,   ctermfg = 9,  ctermbg = 8 })
  hl("TempleMenuCount", { fg = c.base,    bg = c.yellow, ctermfg = 0,  ctermbg = 3 })
  hl("TempleMenuBlink", { fg = c.base,    bg = c.yellow, ctermfg = 8,  ctermbg = 3 }) -- reverse of Base
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  M.define_highlights()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("templemenu_hl", { clear = true }),
    callback = M.define_highlights,
  })
  if M.config.key then
    vim.keymap.set("n", M.config.key, M.open, { desc = "Jump to definitions (templemenu)" })
  end
end

function M.open()
  M.define_highlights()
  require("templemenu.ui").open(M.config)
end

return M
