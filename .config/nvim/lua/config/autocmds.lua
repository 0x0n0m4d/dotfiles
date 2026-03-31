-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Configure markdown
local md_link_pattern = "\\v\\[[^\\]]+\\]\\([^)]+\\)|\\[[^\\]]+\\]\\[[^\\]]*\\]"

local function jump_next_link()
	-- 'W' = don't wrap around end of file
	local found = vim.fn.search(md_link_pattern, "W")
	if found == 0 then
		vim.notify("No next link found", vim.log.levels.INFO)
	end
end

local function jump_prev_link()
	-- 'bW' = search backwards, don't wrap
	local found = vim.fn.search(md_link_pattern, "bW")
	if found == 0 then
		vim.notify("No previous link found", vim.log.levels.INFO)
	end
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function(ev)
		-- vim.cmd([[set nowrap]])
		vim.cmd([[set nospell]])

		-- which-key
		require("which-key").add({
			{ "]]", jump_next_link, desc = "Jump to next markdown link", mode = "n", buffer = ev.buf },
			{ "[[", jump_prev_link, desc = "Jump to previous markdown link", mode = "n", buffer = ev.buf },
		})

		-- mini.surround
		require("mini.surround").setup({
			padding = false, -- No spaces added around surroundings
		})
	end,
})
