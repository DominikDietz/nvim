return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      no_italic = true,
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_italics = true,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      -- vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
