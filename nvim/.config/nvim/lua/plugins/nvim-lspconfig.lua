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
    vim.fn.sign_define("DiagnosticSignError", { text = icons.DiagnosticError, texthl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignHint", { text = icons.DiagnosticHint, texthl = "DiagnosticHint" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = icons.DiagnosticHint, texthl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = icons.DiagnosticWarn, texthl = "DiagnosticWarn" })

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup(lua_ls)
    lspconfig.gopls.setup(gopls)

    -- Enable rounded borders in :LspInfo window.
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
