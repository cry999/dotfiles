local icons = require('icons')
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- test adapters
    "nvim-neotest/neotest-go",
  },
  config = function()
    local namespace = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local virt = diagnostic.message
              :gsub("\n", " ")
              :gsub("\t", " ")
              :gsub("%s+", " ")
              :gsub("^%s+", "")
          return virt
        end,
      },
      icons = {
        -- passed = ico
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        running = icons.TestRunning,
        passed = icons.TestPassed,
        failed = icons.TestFailed,
      }
    }, namespace)
    require("neotest").setup({
      adapters = {
        require("neotest-go"),
      },
    })
  end,
}
