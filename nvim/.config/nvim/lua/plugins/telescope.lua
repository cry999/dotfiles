return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
      { "nvim-lua/plenary.nvim" },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "❯ ",
          selection_caret = "❯ ",
          multi_icon = "❯ ",
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.65,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "-g", "!.git",
          },
          mappings = {
            i = {
              ["<C-y>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-w>"] = actions.select_tab,
            },
            n = {
              ["<C-y>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-w>"] = actions.select_tab,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
        },
      }
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      default_register = '*',
      keys = {
        telescope = {
          i = {
            select = '<cr>',
            paste = '<C-y>',
            paste_behind = {},
            replay = {},
            delete = {},
            edit = {},
          },
          n = {
            select = '<cr>',
            paste = '<C-y>',
            paste_behind = {},
            replay = {},
            delete = {},
            edit = 'e',
          },
        },
      },
    },
  },
}
