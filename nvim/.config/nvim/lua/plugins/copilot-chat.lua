return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      model = 'gpt-4o',
      temperature = 0.1,
      show_user_selection = true,
      show_system_prompt = true,
      show_folds = true,
      name = 'CopilotChat',
      separator = '\n━━━━━\n',
      window = {
        layout = 'float',
        width = 0.9,
        height = 0.7,
        border = 'rounded',
      },
    },
    build = function()
    end,
    event = "VeryLazy",
  },
}
