return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filters = { custom = { "^.git$", "^.github$" } },
    hijack_cursor = true,
    live_filter = {
      always_show_folders = false,
    },
    update_focused_file = {
      enable = true,
    },
    renderer = {
      root_folder_label = false,
    },
    view = {
      cursorline = true,
      -- width = {
      --   min = 30,
      --   padding = 3
      -- }
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      --custom mappings
      vim.keymap.set("n", "<leader>e", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
    end,
  },
}
