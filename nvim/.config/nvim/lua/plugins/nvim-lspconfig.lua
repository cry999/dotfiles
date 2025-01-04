local icons = require("icons")
local gopls = require("lsp.gopls")
local lua_ls = require("lsp.lua_ls")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "williamboman/mason-lspconfig.nvim",
      cmd = { "LspInstall", "LspUninstall" },
      opts = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        return {
          handlers = {
            function(server)
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              }
              require("lspconfig")[server].setup({
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
              })
            end,
          },
        }
      end,
    },
    { "SmiteshP/nvim-navic" },
  },
  config = function()
    vim.diagnostic.config({
      signs = {
        text = {
          ["DiagnosticSignError"] = icons.DiagnosticError,
          ["DiagnosticSignHint"] = icons.DiagnosticHint,
          ["DiagnosticSignInfo"] = icons.DiagnosticHint,
          ["DiagnosticSignWarn"] = icons.DiagnosticWarn,
        },
      },
    })

    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }

    lspconfig.lua_ls.setup(lua_ls)
    lspconfig.gopls.setup(gopls)
    lspconfig.markdown_oxide.setup({
      capabilities = capabilities,
    })

    -- Enable rounded borders in :LspInfo window.
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
