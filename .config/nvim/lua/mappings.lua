local terms = {}
local mappings = {
  n = {
    ["<C-h>"] = { rhs = function() require("smart-splits").move_cursor_left() end, opts = { desc = "Move to left split" } },
    ["<C-l>"] = { rhs = function() require("smart-splits").move_cursor_right() end, opts = { desc = "Move to right split" } },
    ["<C-k>"] = { rhs = function() require("smart-splits").move_cursor_up() end, opts = { desc = "Move to up split" } },
    ["<C-j>"] = { rhs = function() require("smart-splits").move_cursor_down() end, opts = { desc = "Move to down split" } },

    -- fuzzy finder
    ["<leader>ff"] = { rhs = "<cmd>Telescope find_files<cr>", opts = { desc = "Find file" } },
    ["<leader>fb"] = { rhs = "<cmd>Telescope buffers<cr>", opts = { desc = "Find buffer" } },
    ["<leader>fw"] = { rhs = "<cmd>Telescope live_grep<cr>", opts = { desc = "Find word" } },

    ["<leader>e"] = { rhs = "<cmd>Neotree<cr>", opts = { desc = "Toggle NeoTree" } },

    -- LSP
    ["<leader>lm"] = { rhs = "<cmd>Mason<cr>", opts = { desc = "Open LSP package manager" } },
    ["<leader>li"] = { rhs = "<cmd>LspInfo<cr>", opts = { desc = "Open LSP information" } },
    ["<leader>la"] = { rhs = function() vim.lsp.buf.code_action() end, opts = { desc = "LSP code action" } },
    ["<leader>lf"] = { rhs = function() vim.lsp.buf.format() end, opts = { desc = "LSP format buffer" } },
    ["<leader>lr"] = { rhs = function() vim.lsp.buf.rename() end, opts = { desc = "LSP rename current symbol" } },
    ["<leader>lh"] = { rhs = function() vim.lsp.buf.signature_help() end, opts = { desc = "LSP show signature help" } },
    ["K"] = { rhs = function() vim.lsp.buf.hover() end, opts = { desc = "LSP Comment" } },
    ["gd"] = { rhs = function() vim.lsp.buf.definition() end, opts = { desc = "LSP Jump to defition" } },
    ["gy"] = { rhs = function() vim.lsp.buf.type_definition() end, opts = { desc = "LSP Jump to defition of current type" } },
    ["[d"] = { rhs = function() vim.diagnostics.goto_prev() end, opts = { desc = "LSP Previous diagnostic" } },
    ["]d"] = { rhs = function() vim.diagnostics.goto_next() end, opts = { desc = "LSP Next diagnostic" } },

    -- Term
    ["<leader>tl"] = {
      rhs = function()
        if not terms.lazygit then
          terms.lazygit = require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", hidden = true,
            direction = "float" }):toggle()
        end
        terms.lazygit:toggle()
      end,
      opts = { desc = "Open lazygit terminal" },
    },
    ["<leader>tf"] = { rhs = "<cmd>ToggleTerm direction=float<cr>", opts = { desc = "Open floating terminal" } },
    ["<leader>th"] = { rhs = "<cmd>ToggleTerm direction=horizontal<cr>", opts = { desc = "Open horizontal terminal" } },
    ["<leader>tv"] = { rhs = "<cmd>ToggleTerm direction=vertical<cr>", opts = { desc = "Open vertical terminal" } },
    ["<leader>tt"] = { rhs = "<cmd>ToggleTerm direction=tab<cr>", opts = { desc = "Open vertical terminal" } },
  },
  t = {
    ["<C-h>"] = { rhs = [[<cmd>wincmd h<cr>]], opts = { desc = "Move to left split" } },
    ["<C-l>"] = { rhs = [[<cmd>wincmd l<cr>]], opts = { desc = "Move to right split" } },
    ["<C-k>"] = { rhs = [[<cmd>wincmd k<cr>]], opts = { desc = "Move to up split" } },
    ["<C-j>"] = { rhs = [[<cmd>wincmd j<cr>]], opts = { desc = "Move to down split" } },
  },
}

for mode, mappings_in_mode in pairs(mappings) do
  for key, opts in pairs(mappings_in_mode) do
    vim.keymap.set(mode, key, opts.rhs, opts.opts)
  end
end
