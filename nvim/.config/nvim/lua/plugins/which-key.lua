return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'echasnovski/mini.icons', version = false },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    icons = {
      group = " ",
    },
  },
}
