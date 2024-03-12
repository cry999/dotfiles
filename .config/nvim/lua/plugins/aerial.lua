return {
  "stevearc/aerial.nvim",
  opts = {
    attach_mode = "global",
    show_guides = true,
    guides = {
      mid_item   = "├╴",
      last_item  = "└╴",
      nested_top = "│ ",
      whitespace = "  ",
    },
    win_opts = {
      winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
      signcolumn = "yes",
      statuscolumn = " ",
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
