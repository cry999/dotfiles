local icons = {
  File = ' ',
  Module = ' ',
  Namespace = ' ',
  Package = ' ',
  Class = ' ',
  Method = ' ',
  Property = ' ',
  Field = ' ',
  Constructor = ' ',
  Enum = ' ',
  Interface = ' ',
  Function = ' ',
  Variable = ' ',
  Constant = ' ',
  String = ' ',
  Number = ' ',
  Boolean = ' ',
  Array = ' ',
  Object = ' ',
  Key = ' ',
  Null = ' ',
  EnumMember = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' '
}

return {
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      icons = icons,
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = true,
      separator = "  ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = false
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",
    },
    opts = {
      icons = icons,
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      window = {
        border = "rounded",
        size = { width = '90%', height = '60%' },
      },
      use_default_mappings = false,
      source_buffer = {
        reorient = "smart",
      },
    },
    config = function(_, opts)
      local actions = require("nvim-navbuddy.actions")
      opts.mappings = {
        ["<esc>"] = actions.close(),     -- Close and cursor to original location
        ["q"] = actions.close(),

        ["j"] = actions.next_sibling(),         -- down
        ["k"] = actions.previous_sibling(),     -- up

        ["l"] = actions.children(),             -- Move to right panel
        ["0"] = actions.root(),                 -- Move to first panel
        ["Y"] = actions.yank_scope(),           -- Yank the scope to system clipboard "+

        ["h"] = actions.parent(),               -- Move to left panel
        ["v"] = actions.visual_name(),          -- Visual selection of name

        ["V"] = actions.visual_scope(),         -- Visual selection of scope
        ["y"] = actions.yank_name(),            -- Yank the name to system clipboard "+

        ["i"] = actions.insert_name(),          -- Insert at start of name
        ["I"] = actions.insert_scope(),         -- Insert at start of scope

        ["a"] = actions.append_name(),          -- Insert at end of name
        ["A"] = actions.append_scope(),         -- Insert at end of scope

        ["r"] = actions.rename(),               -- Rename currently focused symbol

        ["d"] = actions.delete(),               -- Delete scope

        ["f"] = actions.fold_create(),          -- Create fold of current scope
        ["F"] = actions.fold_delete(),          -- Delete fold of current scope

        ["c"] = actions.comment(),              -- Comment out current scope

        ["<enter>"] = actions.select(),         -- Goto selected symbol
        ["o"] = actions.select(),

        ["J"] = actions.move_down(),          -- Move focused node down
        ["K"] = actions.move_up(),            -- Move focused node up

        ["s"] = actions.toggle_preview(),     -- Show preview of current node

        ["<C-v>"] = actions.vsplit(),         -- Open selected node in a vertical split
        ["<C-s>"] = actions.hsplit(),         -- Open selected node in a horizontal split

        ["t"] = actions.telescope({           -- Fuzzy finder at current level.
          layout_config = {                   -- All options that can be
            height = 0.60,                    -- passed to telescope.nvim's
            width = 0.60,                     -- default can be passed here.
            prompt_position = "top",
            preview_width = 0.50
          },
          layout_strategy = "horizontal",
        }),

        ["?"] = actions.help(),     -- Open mappings help window
      }
      require('nvim-navbuddy').setup(opts)
    end,
  },
}
