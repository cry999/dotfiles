local M = {}

M.mappings = {
  n = {
    -- General search
    ["<C-s>"] = { "<cmd>Telescope symbols<cr>", desc = "Find symbols" },
    ["<leader>fs"] = { "<cmd>Telescope symbols<cr>", desc = "Find symbols" },

    -- Autocommands and commands
    ["<leader>fa"] = { "<cmd>Telescope autocommands<cr>", desc = "Find autocommands" },
    ["<leader>fc"] = { "<cmd>Telescope commands<cr>", desc = "Find commands" },
    ["<leader>fC"] = { "<cmd>Telescope command_history<cr>", desc = "Find command history" },

    -- Buffers and files
    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find files" },

    -- Diagnostics
    ["<leader>fd"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Find diagnostics" },
    ["<leader>fD"] = { "<cmd>Telescope diagnostics<cr>", desc = "Find all diagnostics" },

    -- Help and documentation
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },

    -- Keymaps and marks
    ["<leader>fk"] = { "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
    ["<leader>fm"] = { "<cmd>Telescope marks<cr>", desc = "Find marks" },

    -- Notifications and registers
    ["<leader>fn"] = { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" },
    ["<leader>fr"] = { "<cmd>Telescope registers<cr>", desc = "Find registers" },

    -- Tabs
    ["<leader>ft"] = { function() require("telescope-tabs").list_tabs() end, desc = "Find tabs" },

    -- Text search
    ["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", desc = "Find word" },
    ["<leader>fW"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },

    -- Special searches
    ["<leader>fz"] = { "<cmd>ObsidianSearch<cr>", desc = "Find Zettelkasten notes" },
    ["<leader>f/"] = { "<cmd>Telescope search_history<cr>", desc = "Find search history" },
    ["<leader>fy"] = { function() require("telescope").extensions.neoclip.default() end, desc = "Find yank history" },
  },

  i = {
    ["<C-s>"] = { "<cmd>Telescope symbols<cr>", desc = "Find symbols" },
  },
}

return M