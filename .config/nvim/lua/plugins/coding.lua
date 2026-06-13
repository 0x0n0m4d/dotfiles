return {
	-- Comments
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cn",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = {},
	},

	{
		"numToStr/Comment.nvim",
		opts = {
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = nil,
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = "<leader>c.",
				---Block-comment toggle keymap
				block = "<leader>cb",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = "<leader>c.",
				---Block-comment keymap
				block = "<leader>cb",
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = "<leader>cO",
				---Add comment on the line below
				below = "<leader>co",
				---Add comment at the end of line
				eol = "<leader>ck",
			},
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		},
		lazy = false,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		config = function()
			vim.cmd([[hi RenderMarkdownH1Bg cterm=bold gui=bold guifg=#cc3900 ]])
			vim.cmd([[hi RenderMarkdownH2Bg cterm=bold gui=bold guifg=#007bd3 ]])
			vim.cmd([[hi RenderMarkdownH3Bg cterm=bold gui=bold guifg=#158c82]])
			vim.cmd([[hi RenderMarkdownH4Bg cterm=bold gui=bold guifg=#cc9f00]])
			vim.cmd([[hi RenderMarkdownH5Bg cterm=bold gui=bold guifg=#ba0059]])
			vim.cmd([[hi RenderMarkdownH6Bg cterm=bold gui=bold guifg=#5b7c00]])
			vim.cmd([[hi RenderMarkdownBullet cterm=bold gui=bold guifg=#158c82 ]])
			vim.cmd([[hi RenderMarkdownPending cterm=bold gui=bold guifg=#007bd3 ]])
			vim.cmd([[hi RenderMarkdownFailed cterm=bold gui=bold guifg=#a31210 ]])
			vim.cmd([[hi RenderMarkdownUrgent cterm=bold gui=bold guifg=#cc9f00 ]])
			require("render-markdown").setup({
				completions = {
					lsp = { enabled = true },
					blink = { enabled = true },
				},
				heading = {
					signs = { "󰫎 " },
				},
				latex = {
					enabled = true,
					render_modes = false,
					converter = { "utftex" },
					top_pad = 0,
					bottom_pad = 0,
				},
				win_options = {
					wrap = {
						default = true,
						rendered = true,
					},
				},
				bullet = {
					enabled = true,
					ordered_icons = function(ctx)
						local index = ctx.index
						local function to_letter(n)
							return string.char(string.byte("a") + (n - 1) % 26)
						end
						local function to_roman(n)
							local map = {
								{ 1000, "m" },
								{ 900, "cm" },
								{ 500, "d" },
								{ 400, "cd" },
								{ 100, "c" },
								{ 90, "xc" },
								{ 50, "l" },
								{ 40, "xl" },
								{ 10, "x" },
								{ 9, "ix" },
								{ 5, "v" },
								{ 4, "iv" },
								{ 1, "i" },
							}
							local result = ""
							for _, pair in ipairs(map) do
								while n >= pair[1] do
									result = result .. pair[2]
									n = n - pair[1]
								end
							end
							return result
						end
						local level = (ctx.level or 1)
						local cycle = (level - 1) % 3 + 1
						if cycle == 1 then
							return index .. "."
						elseif cycle == 2 then
							return to_letter(index) .. "."
						else
							return to_roman(index) .. "."
						end
					end,
				},
				checkbox = {
					custom = {
						todo = {
							raw = "[-]",
							rendered = "󱗝 ",
							highlight = "RenderMarkdownPending",
							scope_highlight = nil,
						},
						failed = {
							raw = "[/]",
							rendered = "󰅘 ",
							highlight = "RenderMarkdownFailed",
							scope_highlight = nil,
						},
						urgent = {
							raw = "[!]",
							rendered = "󰳤 ",
							highlight = "RenderMarkdownUrgent",
							scope_highlight = nil,
						},
					},
				},
				callout = {
					note = {
						raw = "[!NOTE]",
						rendered = " Note",
						highlight = "RenderMarkdownInfo",
						category = "github",
					},
					warning = {
						raw = "[!WARNING]",
						rendered = " Warning",
						highlight = "RenderMarkdownWarn",
						category = "github",
					},
					important = {
						raw = "[!IMPORTANT]",
						rendered = "󰨄 Important",
						highlight = "RenderMarkdownHint",
						category = "github",
					},
					todo = {
						raw = "[!TODO]",
						rendered = " Todo",
						highlight = "RenderMarkdownInfo",
						category = "obsidian",
					},
					done = {
						raw = "[!DONE]",
						rendered = "󰸞 Done",
						highlight = "RenderMarkdownSuccess",
						category = "obsidian",
					},
					question = {
						raw = "[!QUESTION]",
						rendered = " Question",
						highlight = "RenderMarkdownHint",
						category = "obsidian",
					},
					fail = {
						raw = "[!FAIL]",
						rendered = "󰛉 Fail",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					error = {
						raw = "[!ERROR]",
						rendered = "󰅚 Error",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					bug = {
						raw = "[!BUG]",
						rendered = " Bug",
						highlight = "RenderMarkdownError",
						category = "obsidian",
					},
					quote = {
						raw = "[!QUOTE]",
						rendered = "󱆨 Quote",
						highlight = "RenderMarkdownQuote",
						category = "obsidian",
					},
					cite = {
						raw = "[!CITE]",
						rendered = "󱆨 Cite",
						highlight = "RenderMarkdownQuote",
						category = "obsidian",
					},
					ia = {
						raw = "[!IA]",
						rendered = "󰚩 IA",
						highlight = "RenderMarkdownHint",
						category = "obsidian",
					},
				},
				link = {
					custom = {
						web = { pattern = "^http", icon = "󰖟 " },
						discord = { pattern = "discord%.com", icon = " " },
						github = { pattern = "github%.com", icon = " " },
						gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
						google = { pattern = "google%.com", icon = " " },
						neovim = { pattern = "neovim%.io", icon = " " },
						reddit = { pattern = "reddit%.com", icon = " " },
						stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
						wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
						medium = { pattern = "medium%.com", icon = "  " },
						youtube = { pattern = "youtube%.com", icon = " " },
						htb = { pattern = "hackthebox%.com", icon = "󰯂 " },
						immunefi = { pattern = "immunefi%.com", icon = "󰯂 " },
						hackerone = { pattern = "hackerone%.com", icon = "󰯂 " },
						intigriti = { pattern = "intigriti%.com", icon = "󰯂 " },
					},
				},
			})
		end,
	},
	-- Go forward/backward with square brackets
	{
		"nvim-mini/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
}
