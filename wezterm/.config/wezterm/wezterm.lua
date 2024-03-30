local wezterm = require('wezterm');

return {
  color_scheme = "Catppuccin Frappe",
  window_background_opacity = 0.90,
  -- window_background_image = os.getenv("HOME") .. "/.config/wezterm/background.gif",
  -- font
  font = wezterm.font("JetBrainsMonoNL Nerd Font Mono"),
  font_size = 12.0,
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
