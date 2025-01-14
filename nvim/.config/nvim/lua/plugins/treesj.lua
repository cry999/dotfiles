return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  opts = {
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 1000,
    cursor_behavior = 'hold',
    notify = true,
    dot_repeat = true,
  },
}
