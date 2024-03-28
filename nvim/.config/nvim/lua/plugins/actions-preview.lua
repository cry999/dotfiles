return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("actions-preview").setup({
      highlight_command = {
        require("actions-preview.highlight").delta(),
      },
    })
  end,
}
