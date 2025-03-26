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
    render_modes = true,
    heading = {
      enabled = true,
      sign = true,
      icons = { '▋ ', '▋▋ ', '▋▋▋ ', '▋▋▋▋ ', '▋▋▋▋▋ ', '▋▋▋▋▋▋ ' },
      signs = { '󰫎 ' },
      width = 'full',
      border = false,
      border_virtual = true,
    },
    paragraph = {
      enabled = true,
    },
    code = {
      enabled = true,
      sign = true,
      width = 'full',
      border = 'thick',
    },
    checkbox = {
      enabled = true,
      position = 'inline',
      checked = { icon = '󰄲 ', highlight = 'RenderMarkdownChecked', scope_highlight = 'RenderMarkdownNotTodo' },
      custom = {
        todo = { raw = '[-]', rendered = ' ', highlight = 'RenderMarkdownTodo', scope_highlight = 'RenderMarkdownNotTodo' },
        focus = { raw = '[f]', rendered = '󰼀 ', highlight = 'RenderMarkdownFocused', scope_highlight = 'RenderMarkdownFocused' },
        caution = { raw = '[!]', rendered = ' ', highlight = 'RenderMarkdownCaution', scope_highlight = 'RenderMarkdownCaution' },
      },
    },
    link = {
      enabled = true,
      custom = {
        example = { pattern = 'example%.com', icon = '󰉹 ' },
      },
    },
    sign = {
      enabled = true,
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
