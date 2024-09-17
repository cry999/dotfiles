return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    file_types = { "markdown", 'copilot-chat' },
    log_level = 'debug',
    render_modes = { 'n', 'v', 'c' },
    anti_conceal = {
      enabled = false,
    },
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value('conceallevel', {}),
        conceallevel = 3,
      },
      concealcursor = {
        default = vim.api.nvim_get_option_value('concealcursor', {}),
        concealcursor = 'nvc',
      },
    },
  },
}
