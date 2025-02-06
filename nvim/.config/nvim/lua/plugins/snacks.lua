local KiB = 1024
local MiB = 1024 * KiB

return {
  'folke/snacks.nvim',
  priority = 1000,
  dependencies = {
    'echasnovski/mini.icons',
  },
  ---@type snacks.Config
  opts = {
    -- ui
    animate = {
      easing = 'outQuad',
      duration = 20,
      fps = 60,
    },
    -- TODO: migrate dashboard from alpha to snacks
    ---@class snacks.dim.Config
    dim = {
      ---@type snacks.scope.Config
      scope = {
        min_size = 1,
        max_size = 1,
      },
      -- animate scopes. Enabled by default for Neovim >= 0.10
      -- Works on older versions but has to trigger redraws during animation.
      ---@type snacks.animate.Config|{enabled?: boolean}
      animate = {
        enabled = true,
        easing = "outQuad",
        duration = {
          step = 20,   -- ms per step
          total = 300, -- maximum duration
        },
      },
    },
    indent = {
      indent = {
        priority = 1,
        enabled = true,
        only_scope = false,
        only_current = false,
        char = '⦙',
        hl = { 'SnacksIndent' }
      },
      animate = {
        enabled = true,
        style = 'out',
        -- See: https://github.com/EmmanuelOga/easing/blob/master/lib/easing.lua
        easing = 'outQuad',
        duration = {
          step = 20,
          total = 500,
        },
      },
      scope = {
        enabled = true,
        priority = 200,
        char = '│',
        hl = 'SnacksIndentScope',
      },
      chunk = {
        enabled = true,
        priority = 200,
        hl = 'SnacksIndentChunk',
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          arrow = '',
        },
      },
    },
    input = { enabled = true },
    -- editor
    -- TODO: setup debug
    explorer = {
      explorer = {
        replace_netrw = true,
      },
      ---@class snacks.picker.explorer.Config: snacks.picker.files.Config|{}
      ---@field follow_file? boolean follow the file from the current buffer
      ---@field tree? boolean show the file tree (default: true)
      ---@field git_status? boolean show git status (default: true)
      ---@field git_status_open? boolean show recursive git status for open directories
      ---@field watch? boolean watch for file changes
      picker = {
        finder = "explorer",
        sort = { fields = { "sort" } },
        supports_live = true,
        tree = true,
        watch = true,
        git_status = true,
        git_status_open = false,
        follow_file = true,
        focus = "list",
        auto_close = false,
        jump = { close = false },
        layout = { preset = "sidebar", preview = false },
        -- to show the explorer to the right, add the below to
        -- your config under `opts.picker.sources.explorer`
        -- layout = { layout = { position = "right" } },
        formatters = { file = { filename_only = true } },
        matcher = { sort_empty = false, fuzzy = false },
        config = function(opts)
          return require("snacks.picker.source.explorer").setup(opts)
        end,
        win = {
          list = {
            keys = {
              ["<BS>"] = "explorer_up",
              ["l"] = "confirm",
              ["h"] = "explorer_close", -- close directory
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open", -- open with system application
              ["P"] = "toggle_preview",
              ["y"] = "explorer_yank",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
              ["]g"] = "explorer_git_next",
              ["[g"] = "explorer_git_prev",
            },
          },
        },
      }
    },
    -- util
    bigfile = {
      enabled = true,
      size = 1 * MiB,
    },
  },
}
