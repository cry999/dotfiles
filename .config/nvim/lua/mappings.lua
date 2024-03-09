local lazygit = nil
local function toggle_lazygit()
  if not lazygit then
    lazygit = require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      name = "lazygit",
      hidden = true,
      direction = "float"
    })
  end
  lazygit:toggle()
end

local mappings = {
  n = {
    ["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    ["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to up split" },
    ["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to down split" },

    -- fuzzy finder

    ["<leader>fa"] = { "<cmd>Telescope autocommands<cr>", desc = "Find autocommands" },
    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
    ["<leader>fc"] = { "<cmd>Telescope commands<cr>", desc = "Find command" },
    ["<leader>fC"] = { "<cmd>Telescope command_history<cr>", desc = "Find command in history" },
    ["<leader>fd"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Find diagnostics current buffer" },
    ["<leader>fD"] = { "<cmd>Telescope diagnostics bufnr=<cr>", desc = "Find all diagnostics" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find file" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
    ["<leader>fk"] = { "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
    ["<leader>fm"] = { "<cmd>Telescope marks<cr>", desc = "Find mark" },
    ["<leader>fn"] = { "<cmd>Telescope notify<cr>", desc = "Find notifications" },
    ["<leader>fr"] = { "<cmd>Telescope registers<cr>", desc = "Find register" },
    ["<leader>ft"] = { function() require("telescope-tabs").list_tabs() end, desc = "Find tabs" },
    ["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", desc = "Find word" },
    ["<leader>fW"] = { "<cmd>Telescope current_buffer_fuzzy_find skip_empty_lines=true<cr>", desc = "Find current buffer" },
    ["<leader>f/"] = { "<cmd>Telescope search_history<cr>", desc = "Find search word in history" },
    ["<leader>fli"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Find implementations" },
    ["<leader>flr"] = { "<cmd>Telescope lsp_references jump_type=vsplit<cr>", desc = "Find references" },

    ["<leader>e"] = { "<cmd>Neotree<cr>", desc = "Toggle NeoTree" },

    -- LSP
    ["<leader>lm"] = { "<cmd>Mason<cr>", desc = "Open LSP package manager" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "Open LSP information" },
    ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
    ["<leader>lf"] = { function() vim.lsp.buf.format() end, desc = "LSP format buffer" },
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "LSP rename current symbol" },
    ["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "LSP show signature help" },
    ["K"] = { function() vim.lsp.buf.hover() end, desc = "LSP Comment" },
    ["gd"] = { function() vim.lsp.buf.definition() end, desc = "LSP Jump to defition" },
    ["gy"] = { function() vim.lsp.buf.type_definition() end, desc = "LSP Jump to defition of current type" },
    ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "LSP Previous diagnostic" },
    ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "LSP Next diagnostic" },

    -- Package manager (Lazy)
    ["<leader>pm"] = { "<cmd>Lazy<cr>", desc = "Open Lazy" },

    -- Term
    ["<leader>tl"] = { toggle_lazygit, desc = "Open lazygit terminal" },
    ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Open floating terminal" },
    ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open horizontal terminal" },
    ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", desc = "Open vertical terminal" },
    ["<leader>tt"] = { "<cmd>ToggleTerm direction=tab<cr>", desc = "Open vertical terminal" },

    -- Source
    ["<leader>ss"] = { "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Re-sourcing init.lua" },
    ["<leader>sp"] = { "<cmd>source %<cr>", desc = "Re-sourcing current file" },

    -- Git
    ["<leader>gb"] = { function() require("gitsigns").toggle_current_line_blame() end, desc = "View git blame" },
    ["<leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View git diff" },

    -- Hop
    ["<leader>h1"] = { "<cmd>HopChar1<cr>", desc = "Hop to char 1" },
    ["<leader>hw"] = { "<cmd>HopWord<cr>", desc = "Hop to word" },
    ["<leader>ha"] = { "<cmd>HopAnywhere<cr>", desc = "Hop to anywhere" },

    -- Outline
    ["<leader>ot"] = { "<cmd>AerialToggle!<cr>", desc = "Toggle outline panel" },

    -- Comment Out
    ["<leader>//"] = { function()
      return vim.v.count == 0
          and "<plug>(comment_toggle_linewise_current)"
          or "<plug>(comment_toggle_linewise_count)"
    end,
      desc = "Toggle comment linewise",
      expr = true,
    },
    ["<leader>/*"] = {
      function()
        return vim.v.count == 0
            and "<plug>(comment_toggle_blockwise_current)"
            or "<plug>(comment_toggle_blockwise_count)"
      end,
      desc = "Toggle comment blockwise",
      expr = true,
    },

    -- Telekasten (Zettelkasten)
    ["<leader>zf"] = { "<cmd>Telekasten find_notes<cr>", desc = "Find Zettelkasten notes" },
    ["<leader>zg"] = { "<cmd>Telekasten search_notes<cr>", desc = "Find Zettelkasten notes by word" },
    ["<leader>zn"] = { "<cmd>Telekasten new_note<cr>", desc = "Find Zettelkasten notes by word" },
    ["<leader>zd"] = { "<cmd>Telekasten new_daily_note<cr>", desc = "Find Zettelkasten notes by word" },

    -- fold
    ["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    ["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    ["zr"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
    ["zm"] = { function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
    ["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
  },
  x = {
    -- Comment out
    ["<leader>//"] = { "<plug>(comment_toggle_linewise_visual)", desc = "Toggle comment linewise" },
    ["<leader>/*"] = { "<plug>(comment_toggle_blockwise_visual)", desc = "Toggle comment blockwise" },
  },
  t = {
    ["<C-h>"] = { [[<cmd>wincmd h<cr>]], desc = "Move to left split" },
    ["<C-l>"] = { [[<cmd>wincmd l<cr>]], desc = "Move to right split" },
    ["<C-k>"] = { [[<cmd>wincmd k<cr>]], desc = "Move to up split" },
    ["<C-j>"] = { [[<cmd>wincmd j<cr>]], desc = "Move to down split" },
    ["<C-\\><C-\\>"] = { [[<C-\><C-n>]], desc = "Escape" },
  },
}


-- register sections
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  local icons = require("icons")
  wk.register({
    ["<leader>f"] = { name = icons.Search .. "  Fuzzy Finder" },
    ["<leader>fl"] = { name = icons.Search .. "  LSP" },
    ["<leader>l"] = { name = icons.ActiveLSP .. "  LSP" },
    ["<leader>p"] = { name = icons.Package .. "  Package Manager" },
    ["<leader>t"] = { name = icons.Terminal .. "  Terminal" },
    ["<leader>s"] = { name = icons.WordFile .. "  Re-Sourcing configurations" },
    ["<leader>g"] = { name = icons.Git .. "  Git" },
    ["<leader>h"] = { name = "󰑣  Hop" },
    ["<leader>o"] = { name = "  Outline" },
    ["<leader>z"] = { name = "󰎚  Zettelkasten" },
    ["<leader>/"] = { name = "// Comment Out" },
  })
end

for mode, mappings_in_mode in pairs(mappings) do
  for key, opts in pairs(mappings_in_mode) do
    local rhs = opts[1]
    opts[1] = nil
    vim.keymap.set(mode, key, rhs, opts)
  end
end
