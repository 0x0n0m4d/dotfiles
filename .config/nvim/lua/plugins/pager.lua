local function open_file_under_cursor()
    local file = vim.fn.expand("<cWORD>")

    if file == "" then
        return
    end

    file = vim.fn.fnamemodify(file, ":p")

    if not vim.uv.fs_stat(file) then
        vim.notify("File not found: " .. file, vim.log.levels.WARN)
        return
    end

    vim.fn.jobstart({
        "zsh",
        "-c",
        [[
            sleep 0.15
            kitten @ close-window --match var:plugin=templeos
            new=$(kitten @ launch --location=hsplit --type=window --cwd=current --var plugin=templeos nvim -- "$1")
            kitten @ action --match id:"$new" layout_action move_to_screen_edge bottom
            kitten @ action --match id:"$new" layout_action bias 65
        ]],
        "_",
        file,
    }, {
        detach = true,
    })
end

local word_ns = vim.api.nvim_create_namespace("kitty_scrollback_word")

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
                        vim.bo.modified = false
                        vim.opt.showcmd = true
                        vim.opt.showmode = true
                        vim.opt.cmdheight = 1
                        vim.opt.scrolloff = 10
                        vim.opt.cursorline = true
                        vim.opt.laststatus = 0
                        vim.opt.relativenumber = true
                        vim.opt.mouse = ""
                        vim.cmd([[set list listchars=tab:>\ ,trail:+,eol:$,nbsp:%]])

                        vim.keymap.set("n", "<CR>", open_file_under_cursor, {
                            buffer = true,
                            silent = true,
                            desc = "Open file under cursor",
                        })
                        vim.api.nvim_set_hl(0, "CursorWord", {
                            reverse = true,
                        })
                    end,
                },
            }
        })
    end,
}
