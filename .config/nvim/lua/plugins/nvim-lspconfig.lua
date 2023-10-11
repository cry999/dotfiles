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
  },
}
