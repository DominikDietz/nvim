local format_options = {
  lsp_format = "fallback",
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
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        go = { "goimport", "gofmt" },
      },
      format_on_save = format_options,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format(format_options)
    end)
  end,
}
