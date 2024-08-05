return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        sync_install = false,
        ignore_install = {},
        ensure_installed = {
          "go",
          "lua",
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
            init_selection = "<A-l>",
            node_incremental = "<A-l>",
            node_decremental = "<A-h>",
            scope_incremental = "<A-L>",
          },
        },
      })
    end, 0)
  end,
}
