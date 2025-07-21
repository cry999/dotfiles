local wezterm = require('wezterm');

local M = {}

function M.opacity_color(color, opa)
  local c = wezterm.color.parse(color)
  local h, s, l, _ = c:hsla()
  return wezterm.color.from_hsla(h, s, l, opa)
end

M.schemes = {}
-- for name, scheme in pairs(wezterm.get_builtin_color_schemes()) do
  -- M.schemes[name] = scheme
-- end

local palettes = {
  ['Catppuccin Latte'] = {
    -- 抹茶ラテ風の調整（nvim設定ベース - 最新版）
    text = '#1f2b1f',
    subtext1 = '#2d3a2d',
    subtext0 = '#3c4b3c',
    overlay2 = '#556655',
    overlay1 = '#748974',
    overlay0 = '#8fa58f',
    surface2 = '#a9bea9',
    surface1 = '#c3d7c3',
    surface0 = '#d6e6d6',
    crust = '#e1eee1',  -- 少し緑が強くなるよう補正
    mantle = '#eaf6ea', -- ミルク寄りの明るいグリーン
    base = '#edf9ed',   -- やや緑がかった優しい背景

    -- アクセントカラー（濃く、しっかり主張）
    rosewater = '#e64553', -- しっかり赤みがある苺ピンク
    flamingo = '#d83a5e',  -- ベリー系レッド
    pink = '#d33893',      -- ビビッドフューシャピンク
    mauve = '#894ec0',     -- 濃いスミレ紫
    red = '#c72039',       -- 漆赤（うるしあか）風
    maroon = '#a32442',    -- 黒蜜寄りの深紅
    peach = '#dd5e00',     -- 焼きピーチ系オレンジ
    yellow = '#c39b00',    -- 金茶・からし色
    green = '#4ca748',     -- 抹茶をより濃く！ほうじ茶寄りも感じる
    teal = '#268e87',      -- 深い抹茶ミント
    blue = '#2a7fff',      -- 抹茶に映える鮮やかブルー
    sky = '#1ea8c8',       -- 透き通る深めの青空
    sapphire = '#0079a6',  -- くっきりした藍色
    lavender = '#6b6cd9',  -- 濃ラベンダーで安定感ある紫
  },
  ['Catppuccin Frappe'] = {
    rosewater = '#f2d5cf',
    flamingo = '#eebebe',
    pink = '#f4b8e4',
    mauve = '#ca9ee6',
    red = '#e78284',
    maroon = '#ea999c',
    peach = '#ef9f76',
    yellow = '#e5c890',
    green = '#a6d189',
    teal = '#81c8be',
    sky = '#99d1db',
    sapphire = '#85c1dc',
    blue = '#8caaee',
    lavender = '#babbf1',
    text = '#c6d0f5',
    subtext1 = '#b5bfe2',
    subtext0 = '#a5adce',
    overlay2 = '#949cbb',
    overlay1 = '#838ba7',
    overlay0 = '#737994',
    surface2 = '#626880',
    surface1 = '#51576d',
    surface0 = '#414559',
    base = '#303446',
    mantle = '#292c3c',
    crust = '#232634',
  },
  ['Catppuccin Macchiato'] = {
    rosewater = '#f4dbd6',
    flamingo = '#f0c6c6',
    pink = '#f5bde6',
    mauve = '#c6a0f6',
    red = '#ed8796',
    maroon = '#ee99a0',
    peach = '#f5a97f',
    yellow = '#eed49f',
    green = '#a6da95',
    teal = '#8bd5ca',
    sky = '#91d7e3',
    sapphire = '#7dc4e4',
    blue = '#8aadf4',
    lavender = '#b7bdf8',
    text = '#cad3f5',
    subtext1 = '#b8c0e0',
    subtext0 = '#a5adcb',
    overlay2 = '#939ab7',
    overlay1 = '#8087a2',
    overlay0 = '#6e738d',
    surface2 = '#5b6078',
    surface1 = '#494d64',
    surface0 = '#363a4f',
    base = '#24273a',
    mantle = '#1e2030',
    crust = '#181926',
  },
  ['Catppuccin Mocha'] = {
    rosewater = '#f5e0dc',
    flamingo = '#f2cdcd',
    pink = '#f5c2e7',
    mauve = '#cba6f7',
    red = '#f38ba8',
    maroon = '#eba0ac',
    peach = '#fab387',
    yellow = '#f9e2af',
    green = '#a6e3a1',
    teal = '#94e2d5',
    sky = '#89dceb',
    sapphire = '#74c7ec',
    blue = '#89b4fa',
    lavender = '#b4befe',
    text = '#cdd6f4',
    subtext1 = '#bac2de',
    subtext0 = '#a6adc8',
    overlay2 = '#9399b2',
    overlay1 = '#7f849c',
    overlay0 = '#6c7086',
    surface2 = '#585b70',
    surface1 = '#45475a',
    surface0 = '#313244',
    base = '#1e1e2e',
    mantle = '#181825',
    crust = '#11111b',
  },
}
M.palettes = palettes

local function select(flavor, accent)
  local c = palettes[flavor]
  -- shorthand to check for the Latte flavor
  local isLatte = flavor == "Catppuccin Latte"

  return {
    foreground = c.text,
    background = c.base,

    cursor_fg = isLatte and c.base or c.crust,
    cursor_bg = c.rosewater,
    cursor_border = c.rosewater,

    selection_fg = c.text,
    selection_bg = c.surface2,

    scrollbar_thumb = c.surface2,

    split = c.overlay0,

    ansi = {
      isLatte and c.subtext1 or c.surface1,
      c.red,
      c.green,
      c.yellow,
      c.blue,
      c.pink,
      c.teal,
      isLatte and c.surface2 or c.subtext1,
    },

    brights = {
      isLatte and c.subtext0 or c.surface2,
      c.red,
      c.green,
      c.yellow,
      c.blue,
      c.pink,
      c.teal,
      isLatte and c.surface1 or c.subtext0,
    },

    indexed = { [16] = c.peach, [17] = c.rosewater },

    -- nightbuild only
    compose_cursor = c.flamingo,

    tab_bar = {
      background = c.crust,
      active_tab = {
        bg_color = c[accent],
        fg_color = c.crust,
      },
      inactive_tab = {
        bg_color = c.mantle,
        fg_color = c.text,
      },
      inactive_tab_hover = {
        bg_color = c.base,
        fg_color = c.text,
      },
      new_tab = {
        bg_color = c.surface0,
        fg_color = c.text,
      },
      new_tab_hover = {
        bg_color = c.surface1,
        fg_color = c.text,
      },
      -- fancy tab bar
      inactive_tab_edge = c.surface0,
    },

    visual_bell = c.surface0,
  }
end

for name, _ in pairs(palettes) do
  M.schemes[name] = select(name, 'green')
end

return M
