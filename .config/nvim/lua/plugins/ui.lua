return {
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local colors = {
                black        = '#282828',
                white        = '#ebdbb2',
                red          = '#fb4934',
                green        = '#98971a',
                blue         = '#458588',
                magenta      = '#b16286',
                yellow       = '#d79921',
                orange       = '#fe8019',
            }
            local mygruv = {
                normal = {
                    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                },
                insert = {
                    a = {bg = colors.orange, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                },
                visual = {
                    a = {bg = colors.magenta, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                },
                replace = {
                    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                },
                command = {
                    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                },
                inactive = {
                    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
                    b = {bg = colors.black, fg = colors.red},
                    c = {bg = colors.black, fg = colors.white}
                }
            }
            require('lualine').setup({
                options = {
                    theme = mygruv,
                    section_separators = "",
                    component_separators = "|",
                },

                sections = {
                    lualine_a = {
                        "mode",
                    },

                    lualine_b = {
                        "branch",
                    },

                    lualine_c = {
                        "filename",
                    },

                    lualine_x = {
                        "filetype",
                    },

                    lualine_y = {
                        "progress",
                    },

                    lualine_z = {
                        "location",
                    },
                },
            })
        end,
    },
}
