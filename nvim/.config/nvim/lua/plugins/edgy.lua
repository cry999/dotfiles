local icons = require("icons")

return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    options = {
      left = { size = 30 },
      bottom = { size = 10 },
      right = { size = 30 },
      top = { size = 10 },
    },
    wo = {
      winfixwidth = true,
      winfixheight = true,
    },
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "toggleterm",
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      {
        name = "help",
        ft = "markdown",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      {
        title = icons.Copilot .. " Copilot",
        ft = "markdown",
        filter = function(buf)
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") == "copilot-chat"
        end,
        size = { height = 0.4 },
      },
    },
    right = {
      {
        title = icons.Test .. " Neotest",
        ft = "neotest-summary",
        open = "Neotest summary",
      },
    },
  },
}
