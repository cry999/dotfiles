return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          find_command = {"rg", "--files", "--hidden", "-g", "!.git"},
        },
      },
    })
  end,
}
