return {
  "rasulomaroff/reactive.nvim",
  event = "BufRead",
  dependencies = {
    "catppuccin/nvim",
  },
  config = function()
    local flavour = require('catppuccin').flavour
    require("reactive").setup({
      load = {
        'catppuccin-' .. flavour .. '-cursor',
        'catppuccin-' .. flavour .. '-cursorline',
      },
    })
  end,
}
