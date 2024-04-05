return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local U = require("catppuccin.utils.colors")
    local tp = false
    require("catppuccin").setup({
      flavour = vim.env.CATPPUCCIN_FLAVOUR or "mocha",
      transparent_background = tp,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
          colored_indent_levels = true,
        },
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neogit = true,
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        octo = true,
        semantic_tokens = true,
        telekasten = true,
        telescope = {
          enable = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        window_picker = true,
      },
      custom_highlights = function(c)
        return {
          -- for neotree
          NeoTreeNormal = { fg = c.text, bg = c.base },
          NeoTreeNormalNC = { fg = c.text, bg = c.base },
          -- for heirline
          TabLine = { fg = c.surface2, bg = tp and c.none or c.base },
          TabLineFill = { fg = c.fg, bg = tp and c.none or c.mantle },
          TabLineSel = { fg = c.fg, bg = tp and c.none or c.base, italic = true },
          WinBar = { fg = c.fg, bg = tp and c.none or c.base },
          -- for LSP
          LspInlayHint = { fg = U.blend(c.overlay0, c.surface0, 0.5), bg = c.none },
          NormalFloat = { fg = c.text, bg = c.none },

          CmpItemKind = { fg = c.base, bg = c.blue },
          CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
          CmpItemKindKeyword = { fg = c.base, bg = c.red },
          CmpItemKindText = { fg = c.base, bg = c.teal },
          CmpItemKindMethod = { fg = c.base, bg = c.blue },
          CmpItemKindConstructor = { fg = c.base, bg = c.blue },
          CmpItemKindFunction = { fg = c.base, bg = c.blue },
          CmpItemKindFolder = { fg = c.base, bg = c.blue },
          CmpItemKindModule = { fg = c.base, bg = c.blue },
          CmpItemKindConstant = { fg = c.base, bg = c.peach },
          CmpItemKindField = { fg = c.base, bg = c.green },
          CmpItemKindProperty = { fg = c.base, bg = c.green },
          CmpItemKindEnum = { fg = c.base, bg = c.green },
          CmpItemKindUnit = { fg = c.base, bg = c.green },
          CmpItemKindClass = { fg = c.base, bg = c.yellow },
          CmpItemKindVariable = { fg = c.base, bg = c.flamingo },
          CmpItemKindFile = { fg = c.base, bg = c.blue },
          CmpItemKindInterface = { fg = c.base, bg = c.yellow },
          CmpItemKindColor = { fg = c.base, bg = c.red },
          CmpItemKindReference = { fg = c.base, bg = c.red },
          CmpItemKindEnumMember = { fg = c.base, bg = c.red },
          CmpItemKindStruct = { fg = c.base, bg = c.blue },
          CmpItemKindValue = { fg = c.base, bg = c.peach },
          CmpItemKindEvent = { fg = c.base, bg = c.blue },
          CmpItemKindOperator = { fg = c.base, bg = c.blue },
          CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
          CmpItemKindCopilot = { fg = c.base, bg = c.teal },

          -- for folding (ufo)
          FoldCol0 = { fg = c.text, bg = U.blend(c.base, c.text, 0.98) },
          FoldCol1 = { fg = c.text, bg = U.blend(c.base, c.text, 0.94) },
          FoldCol2 = { fg = c.text, bg = U.blend(c.base, c.text, 0.89) },
          FoldCol3 = { fg = c.text, bg = U.blend(c.base, c.text, 0.82) },
          FoldCol4 = { fg = c.text, bg = U.blend(c.base, c.text, 0.76) },
          FoldCol5 = { fg = c.text, bg = U.blend(c.base, c.text, 0.70) },
          FoldCol6 = { fg = c.text, bg = U.blend(c.base, c.text, 0.65) },
          FoldCol7 = { fg = c.text, bg = U.blend(c.base, c.text, 0.60) },
          FoldCol8 = { fg = c.text, bg = U.blend(c.base, c.text, 0.55) },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
