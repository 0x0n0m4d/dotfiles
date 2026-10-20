-- Carousel tab names for Neovim (same idea as the kitty tab bar).
-- * each tab is as wide as its name, up to MAX_WIDTH
-- * a name longer than MAX_WIDTH rotates, but ONLY on the focused tab
-- * other tabs stay still, cut to MAX_WIDTH with an ellipsis
local MAX_WIDTH = 15         -- widest a tab name can get
local LOOP_GAP = "   "       -- blank space between the end and the start of the name
local ROTATE_INTERVAL = 0.2  -- seconds per step

-- set by tabline() while the focused tab is rotating; the timer only redraws
-- when needed, so an idle Neovim with short names costs nothing
local rotating = false

local function tab_name(title, focused)
  title = title:upper()
  local len = vim.fn.strchars(title)         -- chars, not bytes (UTF-8 safe)

  if len <= MAX_WIDTH then
    return title                             -- fits: the tab is exactly as wide as the name
  end

  if not focused then                        -- not focused: idle, just cut
    return vim.fn.strcharpart(title, 0, MAX_WIDTH - 1) .. "…"
  end

  rotating = true
  local loop = title .. LOOP_GAP
  local loop_len = len + vim.fn.strchars(LOOP_GAP)
  -- the offset comes from the clock, so the function stays stateless
  local pos = math.floor(vim.uv.hrtime() / 1e9 / ROTATE_INTERVAL) % loop_len
  return vim.fn.strcharpart(loop:rep(3), pos, MAX_WIDTH)
end

local function tabline()
  rotating = false
  local line = {}
  local current_tab = vim.fn.tabpagenr()

  for tab = 1, vim.fn.tabpagenr("$") do
    local buflist = vim.fn.tabpagebuflist(tab)
    local buf = buflist[vim.fn.tabpagewinnr(tab)]

    local name = vim.fn.fnamemodify(vim.fn.bufname(buf), ":t")
    if name == "" then name = "NO_NAME" end
    if vim.bo[buf].modified then name = "+" .. name end

    local focused = tab == current_tab
    name = tab_name(name, focused):gsub("%%", "%%%%")   -- % is special in a tabline

    table.insert(line, focused and "%#TabLineSel#" or "%#TabLine#")
    table.insert(line, "[" .. name .. "]")
  end

  table.insert(line, "%#TabLineFill#")
  return table.concat(line)
end

_G.TabLine = tabline
vim.opt.showtabline = 1        -- only show it when there are 2+ tabs
vim.opt.tabline = "%!v:lua.TabLine()"

-- Neovim only redraws the tabline on events, never on a clock, so ask for a
-- redraw on every step. The old timer is replaced on re-source so they never
-- stack up.
if _G.TabLineTimer then
  pcall(function() _G.TabLineTimer:stop(); _G.TabLineTimer:close() end)
end
_G.TabLineTimer = vim.uv.new_timer()
local ms = math.floor(ROTATE_INTERVAL * 1000)
_G.TabLineTimer:start(ms, ms, vim.schedule_wrap(function()
  -- (with a single tab the bar is hidden and tabline() is not evaluated)
  if rotating and vim.fn.tabpagenr("$") > 1 then vim.cmd.redrawtabline() end
end))
