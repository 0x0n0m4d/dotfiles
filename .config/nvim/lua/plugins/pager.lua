return {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 
        'KittyScrollbackGenerateKittens',
        'KittyScrollbackCheckHealth',
        'KittyScrollbackGenerateCommandLineEditing'
    },
    event = 'User KittyScrollbackLaunch',
    config = function()
        require('kitty-scrollback').setup({
            {
                status_window = {
                    enabled = false
                },
                visual_selection_highlight_mode = "reverse",
                paste_window = {
                    hide_footer = true,

                    winopts_overrides = function()
                        local width = math.floor(vim.o.columns * 0.70)
                        local height = math.floor(vim.o.lines * 0.30)

                        return {
                            relative = "editor",
                            width = width,
                            height = height,
                            col = math.floor((vim.o.columns - width) / 2),
                            row = vim.o.lines - height - 4,
                            border = "single",
                        }
                    end,
                },
                callbacks = {
                    after_ready = function()
                        vim.opt_local.relativenumber = true
                        vim.bo.modified = false
                        vim.opt.showcmd = true
                        vim.opt.cmdheight = 1
                        vim.opt.scrolloff = 10
                        vim.opt.cursorline = true
                        vim.opt.mouse = ""
                        vim.cmd([[set list listchars=tab:>\ ,trail:+,eol:$,nbsp:%]])
                    end,
                },
            }
        })
    end,
}
