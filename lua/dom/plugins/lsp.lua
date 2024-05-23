local on_attach = function(_, bufnr)
  local key_opts = { buffer = bufnr, remap = false }
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, key_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
  vim.keymap.set("n", "gd", builtin.lsp_definitions, key_opts)
  vim.keymap.set("n", "gr", function()
    builtin.lsp_references({ path_display = { "smart" } })
  end, key_opts)
  vim.keymap.set("n", "gI", builtin.lsp_implementations, key_opts)
  vim.keymap.set("n", "gt", builtin.lsp_type_definitions, key_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key_opts)
  vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, key_opts)
  vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, key_opts)
end

local servers = {
  gopls = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })
    end,
  },
}
