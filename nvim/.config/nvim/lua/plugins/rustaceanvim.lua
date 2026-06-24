return {
  'mrcjkb/rustaceanvim',
  version = '^8',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = function()
      local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
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
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      return {
        server = {
          capabilities = capabilities,
          default_settings = {
            ['rust-analyzer'] = {},
          },
        },
      }
    end
  end,
}
