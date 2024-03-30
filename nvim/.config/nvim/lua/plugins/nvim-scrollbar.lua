return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "lewis6991/gitsigns.nvim",
  },
  opts = {
    show = true,
    show_in_active_only = true,
    handle = {
      text = " ",
      blend = 0,
    },
    marks = {
      Search = {
        text = { require("icons").Search },
        color = "#f4b8e4",
      },
    },
    excluded_buffers = {
      "terminal",
    },
    excluded_filetypes = {
      "neo-tree",
      "notify",
      "alpha",
      "cmp_docs",
      "cmp_menu",
      "noice",
      "prompt",
      "TelescopePrompt",
      "NeogitLogView",
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      handle = true,
      search = true,
    },
  },
  config = function(_, opts)
    local scrollbar = require("scrollbar")
    ---@diagnostic disable-next-line: undefined-field
    scrollbar.setup(opts)

    require("scrollbar.handlers.gitsigns").setup()
  end,
}
