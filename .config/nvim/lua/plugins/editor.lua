return {
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        config = function()
            require("oil").setup({
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
}
