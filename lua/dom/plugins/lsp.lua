local on_attach = function(client, bufnr)
  local key_opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, key_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
  vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, key_opts)
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, key_opts)
  vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, key_opts)
  vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, key_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key_opts)
  vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, key_opts)
  vim.keymap.set("n", "<leader>fS", require("telescope.builtin").lsp_dynamic_workspace_symbols, key_opts)

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, {})

  if client.name == "tsserver" and client.supports_method("textDocument/formatting") then
    client.resolved_capabilities.document_formatting = false
  end
end

local servers = {
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
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.code_actions.eslint_d,
        },
        on_attach = function(client, bufnr)
          if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
