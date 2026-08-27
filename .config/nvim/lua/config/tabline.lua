local function tabline()
    local line = {}

    for tab = 1, vim.fn.tabpagenr("$") do
        local current = tab == vim.fn.tabpagenr()

        local wins = vim.fn.tabpagewinnr(tab)
        local buflist = vim.fn.tabpagebuflist(tab)
        local buf = buflist[wins]

        local name = vim.fn.bufname(buf)
        name = vim.fn.fnamemodify(name, ":t")

        if name == "" then
            name = "NO_NAME"
        end

        if vim.bo[buf].modified then
            name = "+" .. name
        end

        if current then
            table.insert(line, "%#TabLineSel#")
        else
            table.insert(line, "%#TabLine#")
        end

        table.insert(line, "[" .. name:upper() .. "]")
    end

    table.insert(line, "%#TabLineFill#")

    return table.concat(line)
end

_G.TabLine = tabline

vim.opt.tabline = "%!v:lua.TabLine()"
