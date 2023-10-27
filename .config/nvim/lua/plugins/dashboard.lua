return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  opts = function()
    return require('alpha.themes.theta').config
  end,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
}
