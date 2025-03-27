return {
	{
		enabled = true,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = function()
			local conf = {
				-- labels = "abcdefghijklmnopqrstuvwxyz",
				labels = "asdfghjklqwertyuiopzxcvbnm",
				search = {
					-- search/jump in all windows
					multi_window = true,
					-- search direction
					forward = true,
					-- when `false`, find only matches in the given direction
					wrap = true,
					---@type Flash.Pattern.Mode
					-- Each mode will take ignorecase and smartcase into account.
					-- * exact: exact match
					-- * search: regular search
					-- * fuzzy: fuzzy search
					-- * fun(str): custom function that returns a pattern
					--   For example, to only match at the beginning of a word:
					--   mode = function(str)
					--     return "\\<" .. str
					--   end,
					mode = "exact",
					-- behave like `incsearch`
					incremental = false,
					-- Excluded filetypes and custom window filters
					---@type (string|fun(win:window))[]
					exclude = {
						"notify",
						"cmp_menu",
						"noice",
						"flash_prompt",
						function(win)
							-- exclude non-focusable windows
							return not vim.api.nvim_win_get_config(win).focusable
						end,
					},
					-- Optional trigger character that needs to be typed before
					-- a jump label can be used. It's NOT recommended to set this,
					-- unless you know what you're doing
					trigger = "",
					-- max pattern length. If the pattern length is equal to this
					-- labels will no longer be skipped. When it exceeds this length
					-- it will either end in a jump or terminate the search
					max_length = false, ---@type number|false
				},
				jump = {
					-- save location in the jumplist
					jumplist = true,
					-- jump position
					pos = "start", ---@type "start" | "end" | "range"
					-- add pattern to search history
					history = false,
					-- add pattern to search register
					register = false,
					-- clear highlight after jump
					nohlsearch = false,
					-- automatically jump when there is only one match
					autojump = false,
					-- You can force inclusive/exclusive jumps by setting the
					-- `inclusive` option. By default it will be automatically
					-- set based on the mode.
					inclusive = nil, ---@type boolean?
					-- jump position offset. Not used for range jumps.
					-- 0: default
					-- 1: when pos == "end" and pos < current position
					offset = nil, ---@type number
				},
				label = {
					-- allow uppercase labels
					uppercase = true,
					-- add any labels with the correct case here, that you want to exclude
					exclude = "",
					-- add a label for the first match in the current window.
					-- you can always jump to the first match with `<CR>`
					current = true,
					-- show the label after the match
					after = true, ---@type boolean|number[]
					-- show the label before the match
					before = false, ---@type boolean|number[]
					-- position of the label extmark
					style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
					-- flash tries to re-use labels that were already assigned to a position,
					-- when typing more characters. By default only lower-case labels are re-used.
					reuse = "lowercase", ---@type "lowercase" | "all" | "none"
					-- for the current window, label targets closer to the cursor first
					distance = true,
					-- minimum pattern length to show labels
					-- Ignored for custom labelers.
					min_pattern_length = 0,
					-- Enable this to use rainbow colors to highlight labels
					-- Can be useful for visualizing Treesitter ranges.
					rainbow = {
						enabled = false,
						-- number between 1 and 9
						shade = 5,
					},
					-- With `format`, you can change how the label is rendered.
					-- Should return a list of `[text, highlight]` tuples.
					---@class Flash.Format
					---@field state Flash.State
					---@field match Flash.Match
					---@field hl_group string
					---@field after boolean
					---@type fun(opts:Flash.Format): string[][]
					format = function(opts)
						return { { opts.match.label, opts.hl_group } }
					end,
				},
				highlight = {
					-- show a backdrop with hl FlashBackdrop
					backdrop = true,
					-- Highlight the search matches
					matches = true,
					-- extmark priority
					priority = 5000,
					groups = {
						match = "FlashMatch",
						current = "FlashCurrent",
						backdrop = "FlashBackdrop",
						label = "FlashLabel",
					},
				},
				-- action to perform when picking a label.
				-- defaults to the jumping logic depending on the mode.
				---@type fun(match:Flash.Match, state:Flash.State)|nil
				action = nil,
				-- initial pattern to use when opening flash
				pattern = "",
				-- When `true`, flash will try to continue the last search
				continue = false,
				-- Set config to a function to dynamically change the config
				config = nil, ---@type fun(opts:Flash.Config)|nil
				-- You can override the default options for a specific mode.
				-- Use it with `require("flash").jump({mode = "forward"})`
				---@type table<string, Flash.Config>
				modes = {
					-- options used when flash is activated through
					-- a regular search with `/` or `?`
					search = {
						-- when `true`, flash will be activated during regular search by default.
						-- You can always toggle when searching with `require("flash").toggle()`
						enabled = true,
						highlight = { backdrop = false },
						jump = { history = true, register = true, nohlsearch = true },
						search = {
							-- `forward` will be automatically set to the search direction
							-- `mode` is always set to `search`
							-- `incremental` is set to `true` when `incsearch` is enabled
						},
					},
					-- options used when flash is activated through
					-- `f`, `F`, `t`, `T`, `;` and `,` motions
					char = {
						enabled = true,
						-- dynamic configuration for ftFT motions
						config = function(opts)
							-- autohide flash when in operator-pending mode
							opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

							-- disable jump labels when not enabled, when using a count,
							-- or when recording/executing registers
							opts.jump_labels = opts.jump_labels
								and vim.v.count == 0
								and vim.fn.reg_executing() == ""
								and vim.fn.reg_recording() == ""

							-- Show jump labels only in operator-pending mode
							-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
						end,
						-- hide after jump when not using jump labels
						autohide = false,
						-- show jump labels
						jump_labels = false,
						-- set to `false` to use the current line only
						multi_line = true,
						-- When using jump labels, don't use these keys
						-- This allows using those keys directly after the motion
						label = { exclude = "hjkliardc" },
						-- by default all keymaps are enabled, but you can disable some of them,
						-- by removing them from the list.
						-- If you rather use another key, you can map them
						-- to something else, e.g., { [";"] = "L", [","] = H }
						keys = { "f", "F", "t", "T", ",", ";" },
						---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
						-- The direction for `prev` and `next` is determined by the motion.
						-- `left` and `right` are always left and right.
						char_actions = function(motion)
							return {
								[","] = "next", -- set to `right` to always go right
								[";"] = "prev", -- set to `left` to always go left
								-- clever-f style
								[motion:lower()] = "next",
								[motion:upper()] = "prev",
								-- jump2d style: same case goes next, opposite case goes prev
								-- [motion] = "next",
								-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
							}
						end,
						search = { wrap = false },
						highlight = { backdrop = true },
						jump = { register = false },
					},
					-- options used for treesitter selections
					-- `require("flash").treesitter()`
					treesitter = {
						labels = "abcdefghijklmnopqrstuvwxyz",
						jump = { pos = "range" },
						search = { incremental = false },
						label = { before = true, after = true, style = "inline" },
						highlight = {
							backdrop = false,
							matches = false,
						},
					},
					treesitter_search = {
						jump = { pos = "range" },
						search = { multi_window = true, wrap = true, incremental = false },
						remote_op = { restore = true },
						label = { before = true, after = true, style = "inline" },
					},
					-- options used for remote flash
					remote = {
						remote_op = { restore = true, motion = true },
					},
				},
				-- options for the floating window that shows the prompt,
				-- for regular jumps
				prompt = {
					enabled = true,
					prefix = { { "⚡", "FlashPromptIcon" } },
					win_config = {
						relative = "editor",
						width = 1, -- when <=1 it's a percentage of the editor width
						height = 1,
						row = -1, -- when negative it's an offset from the bottom
						col = 0, -- when negative it's an offset from the right
						zindex = 1000,
					},
				},
				-- options for remote operator pending mode
				remote_op = {
					-- restore window views and cursor position
					-- after doing a remote operation
					restore = false,
					-- For `jump.pos = "range"`, this setting is ignored.
					-- `true`: always enter a new motion when doing a remote operation
					-- `false`: use the window's cursor position and jump target
					-- `nil`: act as `true` for remote windows, `false` for the current window
					motion = false,
				},
			}
			vim.cmd([[hi FlashLabel cterm=bold gui=bold guifg=#141617 guibg=#fe8019]])
			vim.cmd([[hi FlashMatch cterm=bold gui=bold guifg=#141617 guibg=#fabd2f]])
			return conf
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				add = "<leader>ma", -- Add surrounding in Normal and Visual modes
				delete = "<leader>md", -- Delete surrounding
				find = "<leader>mf", -- Find surrounding (to the right)
				find_left = "<leader>mF", -- Find surrounding (to the left)
				highlight = "<leader>mh", -- Highlight surrounding
				replace = "<leader>mr", -- Replace surrounding
				update_n_lines = "<leader>mn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,

			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = "cover",

			-- Whether to disable showing non-error feedback
			silent = false,
		},
	},

	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
				},
			},
		},
	},
	{
		"telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "dropdown",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("git_worktree")
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{
				";f",
				function()
					local fzf = require("fzf-lua")
					fzf.files({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";c",
				function()
					local fzf = require("fzf-lua")
					fzf.files({
						no_ignore = false,
						hidden = true,
						cwd = "~/.config/nvim/",
					})
				end,
				desc = "Open File Browser with the path of the config file",
			},
			{
				";;",
				function()
					local fzf = require("fzf-lua")
					fzf.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";r",
				function()
					local fzf = require("fzf-lua")
					fzf.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			-- local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				lnum = 40, -- v:lnum
				relnum = 5, -- v:relnum
				virtnum = 0, -- v:virtnum
				buf = 1, -- buffer handle
				win = 1000, -- window handle
				nu = true, -- 'number' option value
				rnu = true, -- 'relativenumber' option value
				empty = true, -- statuscolumn is currently empty
				fold = {
					width = 1, -- current width of the fold column
					-- 'fillchars' option values:
					close = "", -- foldclose
					open = "", -- foldopen
					sep = " ", -- foldsep
				},
				-- FFI data:
				tick = 251ULL, -- display_tick value
				wp = "cdata<struct 112 *>: 0x560b56519a50", -- win_T pointer handle
			})
		end,
	},
}
