local format_options = {
  lsp_fallback = true,
  async = true,
  timeout_ms = 500,
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
      },
      format_on_save = format_options,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format(format_options)
    end)
  end,
}
