return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		on_highlights = function(hl, c)
			hl.Visual = {
				reverse = true,
			}
		end,
	},
}
