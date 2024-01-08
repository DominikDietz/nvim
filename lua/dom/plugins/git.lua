return {
  "tpope/vim-fugitive",
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
    end,
  },
}
