return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.install")
    configs.compilers = { "clang" }

    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        sync_install = false,
        ignore_install = {},

        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "python",
          "rust",
          "tsx",
          "javascript",
          "typescript",
          "vimdoc",
          "vim",
          "bash",
        },

        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end, 0)
  end,
}
