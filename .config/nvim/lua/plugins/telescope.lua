return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
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
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
        },
      })
    end,
  },
  {
    "LukasPietzschmann/telescope-tabs",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = {
      entry_formatter = function(tab_id, _, file_names, file_paths, is_current)
        return string.format('%s %d: %s', is_current and '*' or ' ', tab_id, table.concat(file_names, ', '))
      end,
      entry_ordinal = function(tab_id, _, _, _, is_current)
        return is_current and 0 or tab_id
      end,
    },
  },
}
