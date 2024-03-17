return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "williamboman/mason-lspconfig.nvim",
      cmp = { "LspInstall", "LspUninstall" },
      opts = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        return {
          handlers = {
            function(server)
              require("lspconfig")[server].setup({
                capabilities = cmp_nvim_lsp.default_capabilities(
                  vim.lsp.protocol.make_client_capabilities()
                ),
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
          hints = {
            enable = true,
          },
        },
      },
    })
    -- local inlay_hints = vim.lsp.handlers["textDocument/inlayHint"]
    lspconfig.gopls.setup({
      -- handlers = {
      --   ["textDocument/inlayHint"] = function(err, result, context, config)
      --     for v in pairs(result) do
      --       for k in pairs(result[v].label) do
      --         -- Types: 1: TypeHint, 2: ParameterHint
      --         if result[v].kind == 1 then
      --           result[v].label[k].value = " " .. result[v].label[k].value
      --         elseif result[v].kind == 2 then
      --           result[v].label[k].value = " " .. result[v].label[k].value
      --         end
      --       end
      --     end
      --     return inlay_hints(err, result, context, config)
      --   end,
      -- },
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
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })
  end,
}
