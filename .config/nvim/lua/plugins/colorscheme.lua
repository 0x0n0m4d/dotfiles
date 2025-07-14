return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
				styles = {
					sidebars = "dark",
					floats = "dark",
				},
				on_highlights = function(highlights, colors)
					highlights.Visual = { reverse = true }
					highlights.Search = { bg = colors.red500, fg = colors.base03 }
					highlights.CurSearch = { bg = colors.cyan500, fg = colors.base03 }
					highlights.IncSearch = { bg = colors.red700, fg = colors.base03 }
				end,
			}
		end,
	},
}
