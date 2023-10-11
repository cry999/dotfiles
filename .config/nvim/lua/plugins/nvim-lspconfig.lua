local navic_opts = {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  },
  lsp = {
    auto_attach = true,
    preference = nil,
  },
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true,
  lazy_update_context = false,
  click = false
}
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
}
