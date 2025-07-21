local M = {}

M.mappings = {
  n = {
    -- Dial.nvim - number increment/decrement
    ["<C-a>"] = { function() require("dial.map").manipulate("increment", "normal") end, desc = "Increment number under cursor" },
    ["<C-x>"] = { function() require("dial.map").manipulate("decrement", "normal") end, desc = "Decrement number under cursor" },
    ["g<C-a>"] = { function() require("dial.map").manipulate("increment", "gnormal") end, desc = "Increment number under cursor" },
    ["g<C-x>"] = { function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "Decrement number under cursor" },

    -- Comment toggle
    ["<leader>//"] = { function() require("Comment.api").toggle.linewise.current() end, desc = "Toggle line comment" },
    ["<leader>/*"] = { function() require("Comment.api").toggle.blockwise.current() end, desc = "Toggle block comment" },

    -- Folding (ufo)
    ["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    ["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    ["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },

    -- Wrapping
    ["zw"] = { function() vim.wo.wrap = not vim.wo.wrap end, desc = "Toggle wrap" },

    -- TreeSJ - split/join
    ["<leader>m"] = { function() require("treesj").toggle() end, desc = "Toggle treesj" },

    -- Hop navigation
    ["<leader>h"] = { function() require("hop").hint_char1() end, desc = "Hop to character" },

    -- Navigation
    ["<leader>O"] = { function() require("nvim-navbuddy").open() end, desc = "Open outline navigation" },

    -- File reload
    ["<leader>ss"] = { "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Re-source init.lua" },
    ["<leader>sp"] = { "<cmd>so %<cr>", desc = "Re-source current file" },
  },

  v = {
    -- Dial.nvim in visual mode
    ["<C-a>"] = { function() require("dial.map").manipulate("increment", "visual") end, desc = "Increment number" },
    ["<C-x>"] = { function() require("dial.map").manipulate("decrement", "visual") end, desc = "Decrement number" },
    ["g<C-a>"] = { function() require("dial.map").manipulate("increment", "gvisual") end, desc = "Increment number" },
    ["g<C-x>"] = { function() require("dial.map").manipulate("decrement", "gvisual") end, desc = "Decrement number" },

    -- Comment toggle in visual mode
    ["<leader>//"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle line comment" },
    ["<leader>/*"] = { "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", desc = "Toggle block comment" },

    -- Line movement
    ["K"] = { ":move '<-2<cr>gv-gv", desc = "Move lines up" },
    ["J"] = { ":move '>+1<cr>gv-gv", desc = "Move lines down" },
  },
}

return M