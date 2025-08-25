local wk = require("which-key")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- remove snacks notifier bind
keymap.del("n", "<Leader>n")

-- keymaps
wk.add({
	-- do things without affecting the registers
	{ "\\/", ":noh<Return>", desc = "Clear Selection", mode = "n" },
	{ "x", '"_x', desc = "Remove forward char", mode = "n" },
	{ "dw", 'vb"_d', desc = "Delete a word backwards", mode = "n" },
	{ "c", '"_c', desc = "Change", mode = "n" },
	{ "<C-a>", "gg<S-v>G", desc = "Select all", mode = "n" },
	{ "+", "<C-a>", desc = "Increment number", mode = "n" },
	{ "-", "<C-x>", desc = "Decrement number", mode = "n" },
	{ "<Leader>o", "o<Esc>^Da", desc = "Insert in next line", mode = "n", icon = "", opts },
	{ "<Leader>O", "O<Esc>^Da", desc = "Insert in previous line", mode = "n", icon = "", opts },
	-- tabs
	{ "te", ":tabnew | Oil<Return>", desc = "Create new tab", mode = "n" },
	{ "tx", ":tabclose<Return>", desc = "Close current tab", mode = "n" },
	{ "tp", ":-tabmove<Return>", desc = "Move current tab to next", mode = "n" },
	{ "tn", ":+tabmove<Return>", desc = "Move current to previous", mode = "n" },
	{ "ts", "<C-w>T<Return>", desc = "Move current window to new tab", mode = "n" },
	{ "<tab>", ":tabnext<Return>", desc = "Go to the next tab", mode = "n" },
	{ "<S-tab>", ":tabprev<Return>", desc = "Go to the prev tab", mode = "n" },
	-- move window
	{ "\\h", "<C-w>h", desc = "Go to the left window", mode = "n" },
	{ "\\l", "<C-w>l", desc = "Go to the right window", mode = "n" },
	{ "\\k", "<C-w>k", desc = "Go to the up window", mode = "n" },
	{ "\\j", "<C-w>j", desc = "Go to the down window", mode = "n" },
	-- resize window
	{ "\\H", "<C-w>>", desc = "Increase width", mode = "n" },
	{ "\\L", "<C-w><", desc = "Decrease width", mode = "n" },
	{ "\\K", "<C-w>+", desc = "Increase height", mode = "n" },
	{ "\\J", "<C-w>-", desc = "Increase height", mode = "n" },
	-- file explorer
	{ "<Leader>d", "<cmd>Oil<cr>", desc = "Open parent dir", mode = "n", icon = "" },
	-- lspSaga
	{ "<C-j>", ":Lspsaga diagnostic_jump_next<cr>", desc = "Jump to the next diagnostic", mode = "n", opts },
	{ "H", ":Lspsaga hover_doc<cr>", desc = "Jump to the next diagnostic", mode = "n", opts },
	{ "gl", ":Lspsaga finder<cr>", desc = "Find references and implementations", mode = "n", opts },
	{ "gp", ":Lspsaga peek_definition<cr>", desc = "Show definition", mode = "n", opts },
	{ "gd", ":Lspsaga goto_definition<cr>", desc = "Go to definition", mode = "n", opts },
	{ "gR", ":Lspsaga rename<cr>", desc = "Rename word", mode = "n", opts },
	-- trouble
	{ "<leader>tt", ":Trouble todo<cr>", desc = "Trouble todos", mode = "n" },
	-- git worktree
	{ "<Leader>gw", group = "Git Worktree", mode = "n" },
	{
		"<Leader>gwt",
		"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
		desc = "Git list worktrees",
		mode = "n",
	},
	{
		"<Leader>gwc",
		"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
		desc = "Git create worktrees",
		mode = "n",
	},
})
require("which-key").setup({ preset = "modern" })
