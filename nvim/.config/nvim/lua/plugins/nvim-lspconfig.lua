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

              local ok, config = pcall(require, "lsp." .. server)
              if ok then
                vim.notify("Using custom config for " .. server, vim.log.levels.INFO)
                config = vim.tbl_deep_extend("force", default_config, config)
              else
                vim.notify("Using default config for " .. server, vim.log.levels.INFO)
                config = default_config
              end
              require("lspconfig")[server].setup(config)
            end,
          },
        }
      end,
    },
    { "SmiteshP/nvim-navic" },
  },
  config = function()
    -- Manual LSP configuration for servers not available in mason
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
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
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- Load likec4 LSP configuration
    local ok, likec4_config = pcall(require, "lsp.likec4")
    if ok then
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      
      -- Register likec4 LSP server if not already registered
      if not configs.likec4_lsp then
        configs.likec4_lsp = {
          default_config = vim.tbl_deep_extend("force", { capabilities = capabilities }, likec4_config),
        }
      end
      
      lspconfig.likec4_lsp.setup(vim.tbl_deep_extend("force", { capabilities = capabilities }, likec4_config))
    end

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
