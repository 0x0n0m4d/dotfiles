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

        -- Search
        vim.api.nvim_set_hl(0, "IncSearch", {
            bg = "#458588",
            fg = "#282828",
        })
        vim.api.nvim_set_hl(0, "Search", {
            bg = "#fabd2f",
            fg = "#282828",
        })
        vim.api.nvim_set_hl(0, "CurSearch", {
            bg = "#d3869b",
            fg = "#282828",
        })

        -- Tab
        vim.api.nvim_set_hl(0, "TabLine", {
            fg = "#b8bb26",
            bg = "#282828",
        })

        vim.api.nvim_set_hl(0, "TabLineSel", {
            fg = "#282828",
            bg = "#b8bb26",
            bold = true,
        })

        vim.api.nvim_set_hl(0, "TabLineFill", {
            bg = "#282828",
        })
    end,
}
