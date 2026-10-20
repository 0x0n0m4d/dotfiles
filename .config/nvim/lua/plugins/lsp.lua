return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "gopls",
                "rust_analyzer",
                "clangd",
            },
            automatic_enable = { exclude = { "snyk_ls", "gitlab_duo" } },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        init = function()
            vim.lsp.config("rust_analyzer", {
                cmd = { "nice", "-n", "19", "rust-analyzer" },
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = false,
                        cachePriming = { enable = false },
                        numThreads = 2,
                        lru = { capacity = 64 },
                        lens = { enable = false },
                        inlayHints = { enable = false },
                    },
                },
            })
            local ERROR = { min = vim.diagnostic.severity.ERROR }

            vim.diagnostic.config({
                virtual_text = { severity = ERROR },   -- the text at the end of the line
                underline    = { severity = ERROR },   -- the squiggles under the code
                signs        = { severity = ERROR },   -- the marks in the sign column
                float        = { severity = ERROR },   -- the popup from vim.diagnostic.open_float()
            })
        end,
    },
}
