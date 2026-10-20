return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    config = function()
            vim.cmd([[hi RenderMarkdownPending cterm=bold gui=bold guifg=#83a598 ]])
			vim.cmd([[hi RenderMarkdownFailed cterm=bold gui=bold guifg=#fb4934 ]])
			vim.cmd([[hi RenderMarkdownUrgent cterm=bold gui=bold guifg=#fabd2f ]])
        require("render-markdown").setup({
            completions = {
                lsp = { enabled = false },
                blink = { enabled = false },
            },
            heading = {
                enabled = false
            },
            code = {
                sign = false
            },
            latex = {
                enabled = true,
                render_modes = true,
                converter = { "utftex" },
                position = "center",
                top_pad = 1,
                bottom_pad = 1,
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
}
