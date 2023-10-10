local mappings = {
  n = {
    ["<C-h>"] = { rhs = function() require("smart-splits").move_cursor_left() end, opts = { desc = "Move to left split" } },
    ["<C-l>"] = { rhs = function() require("smart-splits").move_cursor_right() end, opts = { desc = "Move to right split" } },
    ["<C-k>"] = { rhs = function() require("smart-splits").move_cursor_up() end, opts = { desc = "Move to up split" } },
    ["<C-j>"] = { rhs = function() require("smart-splits").move_cursor_down() end, opts = { desc = "Move to down split" } },

    ["<leader>ff"] = { rhs = "<cmd>Telescope find_files<cr>", opts = { desc = "Find file" } },
    ["<leader>fb"] = { rhs = "<cmd>Telescope buffers<cr>", opts = { desc = "Find buffer" } },
  },
}

for mode, mappings_in_mode in pairs(mappings) do
  for key, opts in pairs(mappings_in_mode) do
    vim.keymap.set(mode, key, opts.rhs, opts.opts)
  end
end
