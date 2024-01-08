return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  main = "bufferline",
  opts = function()
    local bufferline = require("bufferline")
    return {
      options = {
        style_preset = {
          -- bufferline.style_preset.minimal,
          bufferline.style_preset.no_italic,
        },
        offsets = {
          {
            filetype = "NvimTree",
            highlight = "Directory",
            separator = false,
          },
        },
        indicator = {
          style = "none",
        },
        -- highlights = require("catppuccin.groups.integrations.bufferline").get()
      },
    }
  end,
}
