return {
	"ellisonleao/gruvbox.nvim",
	-- priority = 1000,
	config = function()
		require("gruvbox").setup({
			invert_selection = true,
			transparent_mode = true,
		})
	end,
}
