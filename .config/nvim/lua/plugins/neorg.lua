return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"nvim-neorg/neorg",
		tag = "v7.0.0",
		dependencies = { "pysan3/neorg-templates" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.itero"] = {},
					["core.syntax"] = {},
					["core.highlights"] = {},
					["core.mode"] = {},
					["core.ui"] = {},
					["core.integrations.treesitter"] = {},
					["core.journal"] = {},
					["core.concealer"] = {
						config = {
							icons = {
								code_block = { conceal = true },
								todo = {
									cancelled = { icon = "" },
									done = { icon = "" },
									on_hold = { icon = "󰏤" },
									pending = { icon = "󱑂" },
									recurring = { icon = "" },
									uncertain = { icon = "" },
									undone = { icon = "" },
									urgent = { icon = "" },
								},
							},
						},
					}, -- Adds pretty icons to your documents
					["core.keybinds"] = {
						config = {
							hook = function(keybinds)
								-- Unmaps any Neorg key from the `norg` mode
								keybinds.unmap("norg", "n", "gtd")
								keybinds.unmap("norg", "n", keybinds.leader .. "nn")

								-- Todo List binds
								keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.cycle")
								keybinds.remap_event("norg", "n", "<Leader>Nd", "core.qol.todo_items.todo.task_done")
								keybinds.remap_event("norg", "n", "<Leader>Nu", "core.qol.todo_items.todo.task_undone")
								keybinds.remap_event("norg", "n", "<Leader>Np", "core.qol.todo_items.todo.task_pending")
								keybinds.remap_event("norg", "n", "<Leader>Nh", "core.qol.todo_items.todo.task_on_hold")
								keybinds.remap_event(
									"norg",
									"n",
									"<Leader>Nc",
									"core.qol.todo_items.todo.task_cancelled"
								)
								keybinds.remap_event(
									"norg",
									"n",
									"<Leader>Nr",
									"core.qol.todo_items.todo.task_recurring"
								)
								keybinds.remap_event(
									"norg",
									"n",
									"<Leader>Ni",
									"core.qol.todo_items.todo.task_important"
								)
								keybinds.remap_event(
									"norg",
									"n",
									"<Leader>N?",
									"core.qol.todo_items.todo.task_uncertain"
								)
							end,
						},
					},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								dashboard = "~/neorg/",
								todo = "~/neorg/todo",
								job = "~/neorg/job",
								projects = "~/neorg/projects",
							},
						},
					},
					["external.templates"] = {
						config = {
							templates_dir = "~/neorg/templates/",
						},
					},
				},
			})
		end,
		run = ":Neorg sync-parsers",
		requires = "nvim-lua/plenary.nvim",
	},
}
