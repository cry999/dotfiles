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
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
          hint = {
            enable = true,
          },
        },
      },
    })
    -- local inlay_hints = vim.lsp.handlers["textDocument/inlayHint"]
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = false,
            constantValues = false,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    local function set_handler_opts_if_not_set(name, handler, opts)
      if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
        vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
      end
    end

    -- Enable rounded borders in :LspInfo window.
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
