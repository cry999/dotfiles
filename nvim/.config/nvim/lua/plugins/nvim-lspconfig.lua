local icons = require("icons")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "williamboman/mason-lspconfig.nvim",
      cmd = { "LspInstall", "LspUninstall" },
      opts = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local gopls = require("lsp.gopls")
        local lua_ls = require("lsp.lua_ls")

        return {
          handlers = {
            function(server)
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              }
              capabilities.workspace = {
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              }

              local default_config = {
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
              }

              if server == "lua_ls" then
                local config = vim.tbl_deep_extend("force", default_config, lua_ls)
                require("lspconfig")[server].setup(config)
              elseif server == "gopls" then
                local config = vim.tbl_deep_extend("force", default_config, gopls)
                require("lspconfig")[server].setup(config)
              elseif server == "markdown_oxide" then
                require("lspconfig")[server].setup(default_config)
              else
                require("lspconfig")[server].setup(default_config)
              end
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
          [vim.diagnostic.severity.ERROR] = icons.DiagnosticError,
          [vim.diagnostic.severity.INFO] = icons.DiagnosticHint,
          [vim.diagnostic.severity.HINT] = icons.DiagnosticHint,
          [vim.diagnostic.severity.WARN] = icons.DiagnosticWarn,
        },
      },
      float = {
        style = "minimal",
        -- border values:
        -- - "none": No border.
        -- - "single": A single line box.
        -- - "double": A double line box.
        -- - "rounded": Like "single", but with rounded corners ("╭" etc.).
        -- - "solid": Adds padding by a single whitespace cell.
        -- - "shadow": A drop shadow effect by blending with the background.
        border = "double",
        -- source = "if_many", -- Or "if_many"
      },
    })

    -- Enable rounded borders in :LspInfo window.
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
