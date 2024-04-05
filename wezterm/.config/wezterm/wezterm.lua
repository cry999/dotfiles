local wezterm = require('wezterm');

return {
  color_scheme = "Catppuccin Frappe",
  -- window_background_opacity = 0.90,
  -- font
  font = wezterm.font_with_fallback(
    { "JetBrainsMono Nerd Font Propo", "UDEV Gothic 35NFLG" },
    { weight = "Regular", style = "Normal", stretch = "Normal" }),
  font_size = 12.0,
  font_rules = {
    -- only bold
    {
      intensity = "Bold",
      italic = false,
      font = wezterm.font_with_fallback(
        { "JetBrainsMono Nerd Font Propo", "UDEV Gothic 35NFLG" },
        { weight = "Bold", style = "Normal", stretch = "Normal" }
      ),
    },
    -- only italic
    {
      intensity = "Normal",
      italic = true,
      font = wezterm.font_with_fallback(
        { "JetBrainsMono Nerd Font Propo", "UDEV Gothic 35NFLG" },
        { weight = "Regular", style = "Italic", stretch = "Normal" }),
    },
    -- bold and italic
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font_with_fallback(
        { "JetBrainsMono Nerd Font Propo", "UDEV Gothic 35NFLG" },
        { weight = "Bold", style = "Italic", stretch = "Normal" }),
    },
  },
  -- tab bar
  use_fancy_tab_bar = true,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  -- cursor
  cursor_thickness = 0.1,
  -- underline
  underline_position = -5,
  underline_thickness = 3,
}
--[[
↓ Font test text ↓
Regular
[1mBold[0m
[3mItalic[0m
[1m[3mBold Italic[0m
[2mHalf Bright[0m
[2m[3mHalf Bright Italic[0m

[5mBlink[0m
[6mRapid Blink[0m
I [1mI[0m [3mI[0m [1m[3mI[0m [2mI[0m [2m[3mI[0m
]]
