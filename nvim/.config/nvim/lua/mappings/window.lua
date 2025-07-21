local M = {}

M.mappings = {
  n = {
    -- Smart splits - window navigation
    ["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    ["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to up split" },
    ["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to down split" },

    -- Smart splits - window resizing
    ["<C-S-H>"] = { function() require("smart-splits").resize_left() end, desc = "Resize left split" },
    ["<C-S-L>"] = { function() require("smart-splits").resize_right() end, desc = "Resize right split" },
    ["<C-S-K>"] = { function() require("smart-splits").resize_up() end, desc = "Resize up split" },
    ["<C-S-J>"] = { function() require("smart-splits").resize_down() end, desc = "Resize down split" },

    -- Window management
    ["<leader>wp"] = { function() require("window-picker").pick_window() end, desc = "Pick any window" },
    ["<leader>wv"] = { "<cmd>vsplit<cr>", desc = "Split window vertical" },
    ["<leader>ws"] = { "<cmd>split<cr>", desc = "Split window horizontal" },
    ["<leader>ww"] = { "<cmd>w<cr>", desc = "Save current window" },
    ["<leader>wW"] = { "<cmd>wa<cr>", desc = "Save all windows" },
    ["<leader>wq"] = { "<cmd>wq<cr>", desc = "Save and quit current window" },
    ["<leader>wQ"] = { "<cmd>wqa<cr>", desc = "Save and quit all windows" },
    ["<leader>wz"] = { "<c-w>_<c-w>|", desc = "Zoom current window" },
    ["<leader>w="] = { "<c-w>=", desc = "Equalize height and width" },
    ["<leader>wo"] = { "<c-w>o", desc = "Close all other windows" },

    -- Tab management
    ["<tab>"] = { "<cmd>tabnext<cr>", desc = "Next tab" },
    ["<S-tab>"] = { "<cmd>tabprev<cr>", desc = "Prev tab" },

    -- Terminal navigation
    ["<leader>qq"] = { "<c-w>q", desc = "Close current window" },
    ["<leader>qQ"] = { "<cmd>qa<cr>", desc = "Quit editor" },
    ["<leader>q<c-Q>"] = { "<cmd>qa!<cr>", desc = "Force quit current window" },
  },

  t = {
    -- Terminal mode navigation
    ["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Move to left split" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Move to right split" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Move to up split" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Move to down split" },
    ["<C-\\><C-\\>"] = { "<C-\\><C-n>", desc = "Escape terminal mode" },
    ["<C-\\>q"] = { "<C-\\><C-n><C-w>q", desc = "Escape and quit terminal" },
  },
}

return M