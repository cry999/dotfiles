return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    file_types = { "markdown", 'copilot-chat' },
    log_level = 'debug',
  },
}
