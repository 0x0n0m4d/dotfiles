return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = false },
		dashboard = {
			enabled = true,
			preset = {
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{
						icon = " ",
						key = "d",
						desc = "File Explorer",
						action = ":Oil",
					},
					{
						icon = "󱎸 ",
						key = "r",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = "󰿅 ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[
███╗   ██╗ ██████╗ ███╗   ███╗██╗  ██╗██████╗ 
████╗  ██║██╔═████╗████╗ ████║██║  ██║██╔══██╗
██╔██╗ ██║██║██╔██║██╔████╔██║███████║██║  ██║
██║╚██╗██║████╔╝██║██║╚██╔╝██║╚════██║██║  ██║
██║ ╚████║╚██████╔╝██║ ╚═╝ ██║     ██║██████╔╝
╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝     ╚═╝╚═════╝]],
			},
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		terminal = { enabled = false },
		win = { enabled = false },
		animate = { enabled = false },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
	},
}
