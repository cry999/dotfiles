local icons = require("icons")

return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
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
      { ft = "qf",            title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "spectre_panel", size = { height = 0.4 } },
      {
        title = icons.Copilot .. " Copilot",
        ft = "markdown",
        filter = function(buf)
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") == "copilot-chat"
        end,
        size = { height = 0.4 },
      },
      {
        title = icons.Test .. " Neotest - Output",
        ft = "neotest-output-panel",
        size = { height = 0.4 },
      },
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = icons.Tree .. " Neo-Tree",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { height = 0.5 },
      },
      {
        title = icons.Test .. " Neotest",
        ft = "neotest-summary",
        pinned = true,
        open = "Neotest summary",
      },
    },
  },
}
