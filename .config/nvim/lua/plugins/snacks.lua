return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000, -- default timeout in ms
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			-- editor margin to keep free. tabline and statusline are taken into account automatically
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true, -- add 1 cell of left/right padding to the notification window
			sort = { "level", "added" }, -- sort by level and time
			-- minimum log level to display. TRACE is the lowest
			-- all notifications are stored in history
			level = vim.log.levels.TRACE,
			icons = {
				error = " ",
				warn = " ",
				info = "󰇥 ",
				debug = " ",
				trace = " ",
			},
			keep = function(notif)
				return vim.fn.getcmdpos() > 0
			end,
			---@type snacks.notifier.style
			style = "compact",
			top_down = true, -- place notifications from top to bottom
			date_format = "%R", -- time format for notifications
			-- format for footer when more lines are available
			-- `%d` is replaced with the number of lines.
			-- only works for styles with a border
			---@type string|boolean
			more_format = " ↓ %d lines ",
			refresh = 50, -- refresh at most every 50ms
		},
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
