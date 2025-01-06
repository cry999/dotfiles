local status = ''

return {
  'folke/zen-mode.nvim',
  opts = {
    on_open = function()
      -- get tmux 'status' config
      status = vim.fn.system('tmux show-options status')
      vim.fn.system('tmux set-option -q status off')
      vim.notify('Zen mode enabled: status=' .. status, vim.log.levels.INFO, { title = 'Zen mode' })
    end,
    on_close = function()
      -- restore tmux 'status' config
      vim.fn.system('tmux set-option -q ' .. status)
      vim.notify('Zen mode disabled', vim.log.levels.INFO, { title = 'Zen mode' })
    end,
  },
}
