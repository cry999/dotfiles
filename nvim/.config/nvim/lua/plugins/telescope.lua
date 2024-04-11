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
          layout_strategy = "vertical",
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
    "LukasPietzschmann/telescope-tabs",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      entry_formatter = function(tab_id, _, file_names, _, is_current)
        return string.format('%s %d: %s', is_current and '*' or ' ', tab_id, table.concat(file_names, ', '))
      end,
      entry_ordinal = function(tab_id, _, _, _, is_current)
        return is_current and 0 or tab_id
      end,
    },
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      require("telescope").load_extension("media_files")
    end,
  },
}
