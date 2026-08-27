return {
    {
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {},
		config = function(_, opts)
			vim.opt.runtimepath:append("/home/n0m4d/.local/share/nvim/site")

			require("nvim-treesitter").setup(vim.tbl_extend("force", opts, {
				parser_install_dir = "/home/n0m4d/.local/share/nvim/site",
				highlight = { enable = true },
			}))
			require("nvim-treesitter").install({
                "bash",
                "zsh",
				"c",
				"python",
				"go",
				"markdown",
				"markdown_inline",
			})
			-- New v1.0 requires manual attachment per buffer
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			-- MDX
			vim.filetype.add({
				extension = {
					mdx = "mdx",
				},
			})
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
