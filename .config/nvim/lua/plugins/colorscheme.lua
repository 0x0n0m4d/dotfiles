return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_transparent_background = true
        vim.g.gruvbox_material_visual = "reverse"
        vim.g.gruvbox_material_enable_bold = true
        vim.cmd.colorscheme("gruvbox-material")

        vim.api.nvim_set_hl(0, "TabLine", {
            fg = "#a89984",
            bg = "#282828",
        })

        vim.api.nvim_set_hl(0, "TabLineSel", {
            fg = "#fe8019",
            bg = "#282828",
            bold = true,
        })

        vim.api.nvim_set_hl(0, "TabLineFill", {
            bg = "#282828",
        })
    end,
}
