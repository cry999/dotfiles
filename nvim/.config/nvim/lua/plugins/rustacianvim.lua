return {
  'mrcjkb/rustaceanvim',
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  version = '^4',
  ft = { 'rust' },
  config = function()
    if not vim.fn.executable('rustup') then
      vim.notify('rustup is not installed', 'error')
      return
    end
    if not pcall(vim.fn.execute, 'rustup which rust-analyzer') then
      -- TODO: exeucte below in background job
      vim.fn.execute('!rustup component add rust-analyzer')
      return
    end
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.g.rustacianvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            capabilities = capabilities,
          },
        },
      },
    }
  end,
}
