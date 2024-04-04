return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  cmd = {
    "AerialToggle",
    "AerialOpen",
    "AerialNavToggle",
    "AerialNavOpen",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    -- NOTE: LSP should be at first to display all kinds.
    backends           = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    attach_mode        = "global",
    layout             = {
      max_width = { 30, 0.2 },
      min_width = { 30, 0.2 },
      win_opts = {
        signcolumn = "yes",
        statuscolumn = " ",
      },
    },
    keymaps            = {
      ["<C-j>"] = nil,
      ["<C-k>"] = nil,
    },
    autojump           = true,
    show_guides        = true,
    guides             = {
      -- When the child item has a sibling below it
      mid_item = "├─ ",
      -- When the child item is the last in the list
      last_item = "╰─ ",
      -- When there are nested child guides to the right
      nested_top = "│  ",
      -- Raw indentation
      whitespace = "  ",
    },
    nav                = {
      border = "rounded",
      max_height = 0.6,
      min_height = 0.6,
      max_width = 0.4,
      min_width = 0.4,
      win_opts = {
        cursorline = true,
        winblend = 30,
      },
      autojump = true,
      preview = true,
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    filter_kind        = false,
  },
}
