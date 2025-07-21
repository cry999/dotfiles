local M = {}

M.mappings = {
  n = {
    -- Neoscroll - smooth scrolling
    ["<C-u>"] = { function() require("neoscroll").ctrl_u({ duration = 250 }) end, desc = "Scroll half up" },
    ["<C-d>"] = { function() require("neoscroll").ctrl_d({ duration = 250 }) end, desc = "Scroll half down" },
    ["<C-b>"] = { function() require("neoscroll").ctrl_b({ duration = 450 }) end, desc = "Scroll up" },
    ["<C-f>"] = { function() require("neoscroll").ctrl_f({ duration = 450 }) end, desc = "Scroll down" },
    ["<C-y>"] = { function() require("neoscroll").scroll(-0.1, { move_cursor = false, duration = 100 }) end, desc = "Scroll 1 up" },
    ["<C-e>"] = { function() require("neoscroll").scroll(0.1, { move_cursor = false, duration = 100 }) end, desc = "Scroll 1 down" },

    -- File explorer
    ["<leader>e"] = { function() require("snacks").explorer() end, desc = "Toggle NeoTree" },

    -- Package management (Lazy)
    ["<leader>pm"] = { "<cmd>Lazy<cr>", desc = "Open Lazy" },
    ["<leader>pc"] = { function() require("lazy.view").view({}, { mode = "close" }) end, desc = "Close Lazy" },

    -- Profiler (snacks)
    ["<leader>Pp"] = { function() require("snacks").profiler.toggle() end, desc = "Toggle profiler" },
    ["<leader>Ph"] = { function() require("snacks").profiler.highlight() end, desc = "Toggle profiler highlights" },
    ["<leader>Ps"] = { function() require("snacks").profiler.scratch() end, desc = "Profiler scratch buffer" },

    -- Terminal (ToggleTerm)
    ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Open floating terminal" },
    ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open horizontal terminal" },
    ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Open vertical terminal" },
    ["<leader>tt"] = { "<cmd>ToggleTerm direction=tab<cr>", desc = "Open tab terminal" },

    -- UI controls
    ["cn"] = { function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Close notifications" },
    ["Z"] = { function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
    ["<leader>sd"] = { function() require("snacks").dim() end, desc = "Toggle snacks.dim" },

    -- Notes
    ["<localleader><localleader>"] = { function() require("telekasten").toggle_todo() end, desc = "Open/toggle task notes" },
  },
}

return M