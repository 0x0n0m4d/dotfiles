return {
	{
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup()
		end,
	},
	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
			},
		},
	},
}
