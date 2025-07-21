local M = {}
local helpers = require("mappings.helpers")

M.mappings = {
  n = {
    -- CopilotChat
    ["<leader>cc"] = { "<cmd>CopilotChatOpen<cr>", desc = "Open CopilotChat" },
    ["<leader>ct"] = { "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat Window" },
    ["<leader>cB"] = { "<cmd>CopilotChatBuffer<cr>", desc = "Chat with current buffer" },
    ["<leader>cr"] = { "<cmd>CopilotChatReset<cr>", desc = "Reset chat history" },

    -- CopilotChat with textobjects
    ["<leader>cif"] = { function() helpers.copilot_chat("@function.inner") end, desc = "Chat about inner function" },
    ["<leader>caf"] = { function() helpers.copilot_chat("@function.outer") end, desc = "Chat about outer function" },
    ["<leader>cib"] = { function() helpers.copilot_chat("@block.inner") end, desc = "Chat about inner block" },
    ["<leader>cab"] = { function() helpers.copilot_chat("@block.outer") end, desc = "Chat about outer block" },
    ["<leader>cil"] = { function() helpers.copilot_chat("@loop.inner") end, desc = "Chat about inner loop" },
    ["<leader>cal"] = { function() helpers.copilot_chat("@loop.outer") end, desc = "Chat about outer loop" },

    -- Telescope integration
    ["<leader>cfp"] = { function() require("CopilotChat.integrations.telescope").pick(require("CopilotChat.actions").prompt_actions()) end, desc = "Prompt actions" },
  },

  v = {
    ["<leader>c"] = { ":CopilotChat ", desc = "Chat about selected contents" },
  },
}

return M