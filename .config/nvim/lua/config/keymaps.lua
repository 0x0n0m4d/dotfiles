local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "\\/", ":noh<Return>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- File Explorer
keymap.set("n", "<Leader>d", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Neorg
keymap.set("n", "<Leader>nwd", ":Neorg workspace dashboard<Return>", { desc = "Notes Dashboard" })
keymap.set("n", "<Leader>nwj", ":Neorg workspace job<Return>", { desc = "Job workspace" })
keymap.set("n", "<Leader>nwr", ":Neorg workspace recon<Return>", { desc = "Recon workspace" })
keymap.set("n", "<Leader>nwn", ":Neorg workspace notes<Return>", { desc = "Notes workspace" })
keymap.set("n", "<Leader>nwp", ":Neorg workspace projects<Return>", { desc = "Projects workspace" })
keymap.set("n", "<Leader>nta", ":Neorg templates audits<Return>", { desc = "Audits templates" })
keymap.set("n", "<Leader>ntb", ":Neorg templates web2<Return>", { desc = "Web2 Bug Bounty templates" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Move window
keymap.set("n", "\\h", "<C-w>h")
keymap.set("n", "\\k", "<C-w>k")
keymap.set("n", "\\j", "<C-w>j")
keymap.set("n", "\\l", "<C-w>l")

-- Resize window
keymap.set("n", "\\L", "<C-w><")
keymap.set("n", "\\H", "<C-w>>")
keymap.set("n", "\\K", "<C-w>+")
keymap.set("n", "\\J", "<C-w>-")

-- Diagnostics
keymap.set("n", "<leader>i", function()
	require("0x0n0m4d.lsp").toggleInlayHints()
end)

-- LspSaga
keymap.set("n", "<C-j>", ":Lspsaga diagnostic_jump_next<Return>", opts)
keymap.set("n", "H", ":Lspsaga hover_doc<Return>", opts)
keymap.set("n", "gl", ":Lspsaga finder<Return>", opts)
keymap.set("n", "gp", ":Lspsaga peek_definition<Return>", opts)
keymap.set("n", "gd", ":Lspsaga goto_definition<Return>", opts)
keymap.set("n", "gR", ":Lspsaga rename<Return>", opts)
keymap.set("n", "<C-k>", ":Lspsaga signature_help<Return>", opts)

-- Git worktree
keymap.set(
	"n",
	"<leader>gwt",
	"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	{ desc = "Git worktrees" }
)
keymap.set(
	"n",
	"<leader>gwc",
	"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	{ desc = "Git create worktree" }
)
