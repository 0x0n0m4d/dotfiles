return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			typescript = { "prettier", "prettierd", stop_after_first = true },
			typescriptreact = { "prettier", "prettierd", stop_after_first = true },
			javascript = { "prettier", "prettierd", stop_after_first = true },
			javascriptreact = { "prettier", "prettierd", stop_after_first = true },
		},
	},
}
