return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local U = require("catppuccin.utils.colors")
    local tp = true
    require("catppuccin").setup({
      flavour = vim.env.CATPPUCCIN_FLAVOUR or "mocha",
      transparent_background = tp,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = true,
        illuminate = true,
        indent_blankline = { enabled = true },
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
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        octo = true,
        semantic_tokens = true,
        telescope = {
          enable = true,
        },
        treesitter = true,
        which_key = true,
      },
      custom_highlights = function(c)
        return {
          -- for heirline
          TabLine = { fg = c.surface2, bg = tp and c.none or c.base },
          TabLineFill = { fg = c.fg, bg = tp and c.none or c.mantle },
          TabLineSel = { fg = c.fg, bg = tp and c.none or c.base, italic = true },
          WinBar = { fg = c.fg, bg = tp and c.none or c.base },
          -- for LSP
          LspInlayHint = { fg = U.blend(c.overlay0, c.surface0, 0.5), bg = c.none },
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
