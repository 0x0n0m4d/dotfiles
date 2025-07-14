return {
	-- tools
	{
		"williamboman/mason.nvim",
		tag = "v1.11.0",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"selene",
				"stylua",
				"luacheck",
				"shellcheck",
				"shfmt",
				"typescript-language-server",
				"tailwindcss-language-server",
				"nomicfoundation-solidity-language-server",
			})
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		opts = {},
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },
		},
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				ts_ls = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					format = "prettierd",
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
				solidity_ls_nomicfoundation = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = true,
					filetypes = { "solidity" },
					cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
				},
				intelephense = {},
				cmake = {
					cmd = { "cmake-laguage-server" },
				},
				clangd = {
					cmd = { "clangd" },
				},
				ruby_lsp = {},
				rust_analyzer = {},
				gopls = {},
				pylsp = {},
				volar = {},
				-- sway_lsp = {
				--   cmd = { "forc-lsp" },
				--   filetypes = { "sway" },
				--   init_options = {
				--     -- Any initialization options
				--     logging = { level = "trace" },
				--   },
				--   root_dir = function(fname)
				--     return require("lspconfig.util").find_git_ancestor(fname)
				--   end,
				-- },
			},
			setup = {},
		},
	},
}
