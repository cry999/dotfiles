return {
  'shellRaining/hlchunk.nvim',
  event = { 'UIEnter' },
  dependencies = {
    'catppuccin/nvim',
  },
  config = function()
    local C = require("catppuccin.palettes").get_palette()
    require('hlchunk').setup({
      chunk = {
        chars = {
          right_arrow = '→',
        },
        style = {
          { fg = C.green },
          { fg = C.red },
        },
      },
    })
  end,
}
