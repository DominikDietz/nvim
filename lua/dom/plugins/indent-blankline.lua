return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      indent = {
        char = "▏",
      },
      scope = {
        show_start = false,
        char = "▏",
      },
    })
  end,
}
