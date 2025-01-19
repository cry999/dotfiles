return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    file_types = { "markdown", 'copilot-chat', 'Avante' },
    log_level = 'debug',
    render_modes = { 'n', 'v', 'c' },
    anti_conceal = {
      enabled = false,
    },
    heading = {
      enabled = true,
      signs = { '󰫎 ' },
      border = true,
      border_virtual = true,
    },
    checkbox = {
      enabled = true,
      checked = { icon = '󰄲 ', highlight = 'RenderMarkdownChecked', scope_highlight = 'RenderMarkdownNotTodo' },
      custom = {
        todo = { raw = '[-]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = 'RenderMarkdownNotTodo' },
        focus = { raw = '[f]', rendered = '󰼀 ', highlight = 'RenderMarkdownFocused', scope_highlight = 'RenderMarkdownFocused' },
      },
    },
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value('conceallevel', {}),
        conceallevel = 3,
      },
      concealcursor = {
        default = vim.api.nvim_get_option_value('concealcursor', {}),
        concealcursor = 'niv',
      },
    },
  },
  ft = { 'markdown', 'copilot-chat', 'Avante' },
}
