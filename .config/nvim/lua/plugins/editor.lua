return {
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        config = function()
            require("oil").setup({
                watch_for_changes = true,
                columns = {
                    "permissions",
                    "size",
                    "mtime",
                },
                view_options = {
                    show_hidden = true,
                },
                keymaps = {
                    ["<C-s>"] = function()
                        require("oil").save({ confirm = false, })
                    end,
                }
            })
        end
    },
    {
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "background",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_hsl_without_function = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_tailwind = true,
		},
	},
}
