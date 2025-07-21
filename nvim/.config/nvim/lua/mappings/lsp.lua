local M = {}

M.mappings = {
  n = {
    -- LSP management
    ["<leader>lm"] = { "<cmd>Mason<cr>", desc = "Open Mason" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "Open LSP information" },

    -- LSP actions
    ["<leader>la"] = { function() require("actions-preview").code_actions() end, desc = "LSP code action" },
    ["<leader>lf"] = { function() vim.lsp.buf.format() end, desc = "LSP format buffer" },
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "LSP rename current symbol" },
    ["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "LSP show signature help" },

    -- LSP navigation
    ["K"] = { function() vim.lsp.buf.hover() end, desc = "LSP hover documentation" },
    ["gd"] = { function() vim.lsp.buf.definition() end, desc = "Jump to definition" },
    ["gy"] = { function() vim.lsp.buf.type_definition() end, desc = "Jump to type definition" },

    -- Diagnostics
    ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
    ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },

    -- Telescope LSP
    ["<leader>fli"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Find implementations" },
    ["<leader>flr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
  },
}

return M
