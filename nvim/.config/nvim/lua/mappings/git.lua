local M = {}

M.mappings = {
  n = {
    -- Neogit
    ["<leader>gg"] = { "<cmd>Neogit<cr>", desc = "Open Neogit" },

    -- Gitsigns
    ["<leader>gb"] = { function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle current line blame" },
    ["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View git diff" },
    ["<leader>g]"] = { function() require("gitsigns").next_hunk() end, desc = "Next git hunk" },
    ["<leader>g["] = { function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" },
    ["<leader>gK"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview current line's git diff" },
  },
}

return M