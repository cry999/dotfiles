return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  config = function()
    require("toggleterm").setup({
      direction = "float",
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      shading_factor = 2,
      float_opts = { border = "rounded" },
    })
  end,
}
