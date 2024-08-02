return {
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup()
    end,
  },
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
      },
    },
  },
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({ enable_builtin = true })
      vim.cmd([[hi OctoEditable guibg=none]])
    end,
    keys = {
      { "<leader>G", "<cmd>Octo<cr>", desc = "Octo" },
      { "<leader>gi", "<cmd>Octo issue create<cr>", desc = "Git create issue" },
      { "<leader>gl", "<cmd>Octo issue list<cr>", desc = "Git list issues" },
      { "<leader>gx", "<cmd>Octo issue close<cr>", desc = "Git close issue" },
    },
  },
}
