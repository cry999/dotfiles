return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      model = 'gpt-4',
      temperature = 0.1,
      proxy = nil,
      allow_insecure = false,
      debug = false,
      show_user_selection = true,
      show_system_prompt = true,
      show_folds = true,
      name = 'CopilotChat',
      separator = '\n━━━━━\n',
    },
    build = function()
    end,
    event = "VeryLazy",
  },
}
