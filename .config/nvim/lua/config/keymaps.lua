vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<C-'>", "<cmd>q<CR>")
vim.keymap.set("n", "<C-q>", "<cmd>q!<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>x<CR>")
vim.keymap.set("n", "\\/", "<cmd>noh<CR>")
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "dw", 'vb"_d')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

vim.keymap.set("n", "<leader>o", "<cmd>put _<CR>")
vim.keymap.set("n", "<leader>O", "<cmd>put! _<CR>")

vim.keymap.set("n", "<leader>d.", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>dv", "<cmd>vsplit | Oil<CR>")
vim.keymap.set("n", "<leader>dh", "<cmd>split | Oil<CR>")
vim.keymap.set("n", "<leader>dt", "<cmd>tabnew | Oil<CR>")

vim.keymap.set("n", "<leader>nv", "<cmd>vnew<CR>")
vim.keymap.set("n", "<leader>nh", "<cmd>new<CR>")
vim.keymap.set("n", "<leader>nt", "<cmd>tabnew<CR>")

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>")

vim.keymap.set("n", "<leader>w_", "<C-w>_")
vim.keymap.set("n", "<leader>w|", "<C-w>|")
vim.keymap.set("n", "<leader>w=", "<C-w>=")

vim.keymap.set("n", "<leader>tp", "<cmd>-tabmove<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>+tabmove<CR>")
vim.keymap.set("n", "<leader>ts", "<C-w>T")
vim.keymap.set("n", "\\h", "<C-w>h")
vim.keymap.set("n", "\\l", "<C-w>l")
vim.keymap.set("n", "\\j", "<C-w>j")
vim.keymap.set("n", "\\k", "<C-w>k")
vim.keymap.set("n", "\\H", "<C-w>>")
vim.keymap.set("n", "\\L", "<C-w><")
vim.keymap.set("n", "\\J", "<C-w>-")
vim.keymap.set("n", "\\K", "<C-w>+")
vim.keymap.set("n", "<leader>.", "zL")
vim.keymap.set("n", "<leader>,", "zH")
vim.keymap.set("n", "<tab>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<S-tab>", "<cmd>tabprevious<CR>")

vim.keymap.set("i", "<C-CR>", "<C-o>o")
vim.keymap.set("i", "<C-S-CR>", "<C-o>O")
