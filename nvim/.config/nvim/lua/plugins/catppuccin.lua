local ui_options = require("ui.options")

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local U = require("catppuccin.utils.colors")
    require("catppuccin").setup({
      flavour = vim.env.CATPPUCCIN_FLAVOUR or 'macchiato',
      transparent_background = ui_options.transparent,
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          scope_color = "mauve",
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
        rainbow_delimiters = true,
        semantic_tokens = true,
        snacks = true,
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
          NeoTreeNormal = { fg = c.text, bg = ui_options.transparent and c.none or c.base },
          NeoTreeNormalNC = { fg = c.text, bg = ui_options.transparent and c.none or c.base },
          -- for LSP
          LspInlayHint = { fg = U.blend(c.overlay0, c.surface0, 0.5), bg = c.none },

          CmpItemKind = { fg = c.base, bg = c.blue, blend = ui_options.transparent and 50 or nil },
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
          FoldCol4 = { fg = c.text, bg = U.blend(c.base, c.text, 0.72) },
          FoldCol5 = { fg = c.text, bg = U.blend(c.base, c.text, 0.62) },
          FoldCol6 = { fg = c.text, bg = U.blend(c.base, c.text, 0.50) },
          FoldCol7 = { fg = c.text, bg = U.blend(c.base, c.text, 0.40) },
          FoldCol8 = { fg = c.text, bg = U.blend(c.base, c.text, 0.30) },

          -- for render-markdown
          ['@markup.quote'] = { fg = c.overlay0, bold = true },
          RenderMarkdownFocused = { fg = c.red, underline = true },
          RenderMarkdownNotToDo = { fg = c.overlay0, strikethrough = true },
          RenderMarkdownCaution = { fg = c.yellow },

          -- for orgmode
          ['@org.headline.level1'] = { link = '@markup.heading.1.markdown' },
          ['@org.headline.level2'] = { link = '@markup.heading.2.markdown' },
          ['@org.headline.level3'] = { link = '@markup.heading.3.markdown' },
          ['@org.headline.level4'] = { link = '@markup.heading.4.markdown' },
          ['@org.headline.level5'] = { link = '@markup.heading.5.markdown' },
          ['@org.headline.level6'] = { link = '@markup.heading.6.markdown' },

          -- for snacks
          SnacksIndent = { fg = c.overlay0 },
          SnacksIndentScope = { fg = c.yellow },
          SnacksIndentChunk = { fg = c.green },
        }
      end,
      color_overrides = {
        frappe = {
          text = "#F4CDE9",
          subtext1 = "#DEBAD4",
          subtext0 = "#C8A6BE",
          overlay2 = "#B293A8",
          overlay1 = "#9C7F92",
          overlay0 = "#866C7D",
          surface2 = "#705867",
          surface1 = "#5A4551",
          surface0 = "#44313B",
        },
        latte = {
          text      = "#1f2b1f",
          subtext1  = "#2d3a2d",
          subtext0  = "#3c4b3c",
          overlay2  = "#556655",
          overlay1  = "#748974",
          overlay0  = "#8fa58f",
          surface2  = "#a9bea9",
          surface1  = "#c3d7c3",
          surface0  = "#d6e6d6",
          crust     = "#e1eee1", -- 少し緑が強くなるよう補正
          mantle    = "#eaf6ea", -- ミルク寄りの明るいグリーン
          base      = "#edf9ed", -- ☘️ やや緑がかった優しい背景

          -- 🍡 アクセントカラー（濃く、しっかり主張）
          rosewater = "#e64553", -- しっかり赤みがある苺ピンク
          flamingo  = "#d83a5e", -- ベリー系レッド
          pink      = "#d33893", -- ビビッドフューシャピンク
          mauve     = "#894ec0", -- 濃いスミレ紫
          red       = "#c72039", -- 漆赤（うるしあか）風
          maroon    = "#a32442", -- 黒蜜寄りの深紅
          peach     = "#dd5e00", -- 焼きピーチ系オレンジ
          yellow    = "#c39b00", -- 金茶・からし色
          green     = "#4ca748", -- 抹茶をより濃く！ほうじ茶寄りも感じる
          teal      = "#268e87", -- 深い抹茶ミント
          blue      = "#2a7fff", -- 抹茶に映える鮮やかブルー
          sky       = "#1ea8c8", -- 透き通る深めの青空
          sapphire  = "#0079a6", -- くっきりした藍色
          lavender  = "#6b6cd9"  -- 濃ラベンダーで安定感ある紫
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
