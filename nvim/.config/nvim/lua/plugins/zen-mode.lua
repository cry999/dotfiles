return {
  'folke/zen-mode.nvim',
  dependencies = {
    { 'folke/twilight.nvim' },
  },
  opts = {
    plugins = {
      twilight = { enabled = false },
      tmux = { enabled = true },
      wezterm = { enabled = true, font = '+0' },
    },
  },
}
