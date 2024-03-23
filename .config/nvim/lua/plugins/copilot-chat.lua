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
      context = 'manual', -- 'buffers' | 'buffer' | 'manual'
      proxy = nil,
      allow_insecure = false,
      debug = false,
      show_user_selection = true,
      show_system_prompt = true,
      show_folds = true,
      clear_chat_on_new_prompt = false,
      auto_follow_cursor = false,
      name = 'CopilotChat',
      separator = '\n━━━━━',
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
  },
}
