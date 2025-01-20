local wezterm = require('wezterm');
local mux = wezterm.mux

-- local opacity = 0.55
local opacity = 1
local ok, color_scheme_name = pcall(require, 'theme')
if not ok then color_scheme_name = 'Catppuccin Macchiato' end

-- See: https://github.com/catppuccin/wezterm/blob/main/plugin/init.lua
local colors = {
  ['Catppuccin Latte'] = {
    rosewater = '#dc8a78',
    flamingo = '#dd7878',
    pink = '#ea76cb',
    mauve = '#8839ef',
    red = '#d20f39',
    maroon = '#e64553',
    peach = '#fe640b',
    yellow = '#df8e1d',
    green = '#40a02b',
    teal = '#179299',
    sky = '#04a5e5',
    sapphire = '#209fb5',
    blue = '#1e66f5',
    lavender = '#7287fd',
    text = '#4c4f69',
    subtext1 = '#5c5f77',
    subtext0 = '#6c6f85',
    overlay2 = '#7c7f93',
    overlay1 = '#8c8fa1',
    overlay0 = '#9ca0b0',
    surface2 = '#acb0be',
    surface1 = '#bcc0cc',
    surface0 = '#ccd0da',
    crust = '#dce0e8',
    mantle = '#e6e9ef',
    base = '#eff1f5',
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
local color_palette = colors[color_scheme_name]

local function opacity_color(color, opa)
  local c = wezterm.color.parse(color)
  local h, s, l, _ = c:hsla()
  return wezterm.color.from_hsla(h, s, l, opa)
end

---@class TabInformation
---The TabInformation struct describes a tab.
---TabInformation is purely a snapshot of some of the key characteristics of the tab, intended for use in synchronous, fast, event callbacks that format GUI elements such as the window and tab title bars.
---@field tab_id integer the identifier for the tab
---@field tab_index integer the logical tab position within its containing window, with 0 indicating the leftmost tab
---@field is_active boolean is true if this tab is the active tab
---@field active_pane PaneInformation the PaneInformation for the active pane in this tab
---@field window_id integer the ID of the window that contains this tab (Since: Version 20220807-113146-c2fee766)
---@field window_title string the title of the window that contains this tab (Since: Version 20220807-113146-c2fee766)
---@field tab_title string the title of the tab (Since: Version 20220807-113146-c2fee766)

---@class PaneInformation
---The PaneInformation struct describes a pane.
---Unlike the Pane object, PaneInformation is a snapshot of some of the key characteristics of the pane, intended for use in synchronous, fast, event callbacks that format GUI elements such as the window and tab title bars.
---@field pane_id integer the pane identifier number
---@field pane_index integer the logical position of the pane within its containing layout
---@field is_active boolean is true if the pane is the active pane within its containing tab
---@field is_zoomed boolean is true if the pane is in the zoomed state
---@field left integer the cell x coordinate of the left edge of the pane
---@field top integer the cell y coordinate of the top edge of the pane
---@field width integer the width of the pane in cells
---@field height integer the height of the pane in cells
---@field pixel_width integer the width of the pane in pixels
---@field pixel_height integer the height of the pane in pixels
---@field title string the title of the pane, per pane:get_title() at the time the pane information was captured
---@field user_vars table the user variables defined for the pane, per pane:get_user_vars() at the time the pane information was captured.
local PaneInformation = {}

---dummy
---@return string
function PaneInformation.get_foreground_process_name() return '' end

wezterm.on('gui-attached', function()
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('update-status', function(window, _)
  -- TODO: centerieze tab title
  --
  local tabs = window:mux_window():tabs()
  local mid_width = 0
  local total_title = ''
  for idx, tab in ipairs(tabs) do
    local title = tab:get_title()
    total_title = total_title .. title
    mid_width = mid_width
        + 1 + math.floor(math.log(idx, 10)) + 1 -- space + index + space
        + 6 + #title + 2                        -- title
        + 2                                     -- tail
        + 2                                     -- space
  end
  local tab_width = window:active_tab():get_size().cols
  local max_left = tab_width / 2 - mid_width / 2

  window:set_left_status(wezterm.format({
    { Background = { Color = opacity_color(color_palette.base, opacity) } },
    { Text = wezterm.pad_left(' ', max_left) },
  }))
  window:set_right_status(wezterm.format({
    { Background = { Color = opacity_color(color_palette.base, opacity) } },
    { Text = wezterm.pad_right(' ', max_left) },
  }))
end)

---basename
---@param s string
---@return string
local function basename(s)
  local base = string.gsub(s, '(.*[/\\])(.*)', '%2')
  return base
end

---proc icon
---@param proc string
---@return string, string
local function proc_icon(proc)
  if proc == 'nvim' then
    return wezterm.nerdfonts.custom_neovim, ''
  elseif proc:match('.*sh') then
    return wezterm.nerdfonts.oct_terminal, ''
  elseif proc == 'yazi' then
    return wezterm.nerdfonts.md_duck, ''
  end
  return '', proc
end

---tidy_pane_title
---@param pane_title string
local function tidy_pane_title(pane_title)
  local max_width = 20
  if pane_title:match('Copy mode:%s*(%w)') then
    return string.gsub(pane_title, 'Copy mode:%s*(%w)', '%1')
  end
  if pane_title:match('Yazi:%s*(.)') then
    local fullpath = string.gsub(pane_title, 'Yazi:%s*(.)', '%1')
    return basename(fullpath)
  end
  return pane_title:sub(1, max_width)
end

---decorate_tab_title
---@param tab TabInformation
---@param fg string
---@param bg string
---@return table
local function decorate_tab(tab, fg, bg)
  -- TODO: get max_width from config
  local pane = tab.active_pane
  ---@diagnostic disable-next-line: undefined-field
  local proc = pane.foreground_process_name
  local icon, procname = proc_icon(basename(proc))
  local title = procname .. '  ' .. tidy_pane_title(pane.title)

  local index = {
    { Foreground = { Color = fg } },
    { Background = { Color = 'none' } },
    { Text = wezterm.nerdfonts.ple_left_half_circle_thick },
    { Foreground = { Color = bg } },
    { Background = { Color = fg } },
    { Text = icon .. ' ' .. (tab.tab_index + 1) .. '' },
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = wezterm.nerdfonts.ple_right_half_circle_thick },
  }
  local title_attrs = {
    { Text = ' ' .. title .. ' ' },
    { Foreground = { Color = bg } },
  }

  local attributes = {}
  for _, attr in ipairs(index) do
    table.insert(attributes, attr)
  end
  for _, attr in ipairs(title_attrs) do
    table.insert(attributes, attr)
  end
  table.insert(attributes, { Background = { Color = 'none' } })
  table.insert(attributes, { Foreground = { Color = bg } })
  table.insert(attributes, { Text = wezterm.nerdfonts.ple_right_half_circle_thick .. ' ' })
  -- table.insert(attributes, { Text = ' ' })
  return attributes
end

wezterm.on('format-tab-title',
  ---@param tab TabInformation
  ---@param _tabs TabInformation[]
  ---@param _panes PaneInformation[]
  ---@param _config any
  ---@param _hover any
  ---@param _max_width any
  ---@return table
  ---@diagnostic disable-next-line: unused-local
  function(tab, _tabs, _panes, _config, _hover, _max_width)
    local bg = opacity_color(color_palette.surface0, opacity)
    if tab.is_active then
      return decorate_tab(tab, color_palette.blue, bg)
    end

    return decorate_tab(tab, color_palette.surface2, bg)
  end)

---activate_tab
---@param index number
local function activate_tab(index)
  return {
    key = tostring(index),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(index - 1),
  }
end

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

---navigate_or_send_key
---@param key string
---@return table
local function navigate_or_send_key(key)
  return {
    key = key,
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action({ SendKey = { key = key, mods = 'CTRL' } }, pane)
      else
        window:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end)
  }
end

---action_navigate_or_send_key
---@param key string
---@return table
local function action_navigate_or_send_key(key)
  return wezterm.action_callback(function(window, pane)
    if is_vim(pane) then
      window:perform_action({ SendKey = { key = key, mods = 'CTRL' } }, pane)
    else
      window:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
    end
  end)
end

---resize_pane
---@param key string
---@return table
local function resize_pane(key)
  return wezterm.action_callback(function(window, pane)
    window:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
  end)
end

local leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }
local keys = {
  { key = ':', mods = 'LEADER', action = wezterm.action.ActivateCommandPalette },
  { key = '[', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(-1) },
  { key = ']', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(1) },
  --
  -- tab operation
  --
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  activate_tab(1),
  activate_tab(2),
  activate_tab(3),
  activate_tab(4),
  activate_tab(5),
  activate_tab(6),
  activate_tab(7),
  activate_tab(8),
  activate_tab(9),
  --
  -- pane operation
  --
  -- splits
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal },
  { key = '|', mods = 'LEADER', action = wezterm.action.SplitHorizontal },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical },
  { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical },
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  -- move
  navigate_or_send_key('h'),
  navigate_or_send_key('j'),
  navigate_or_send_key('k'),
  navigate_or_send_key('l'),
  -- resize
  --
  -- enter resize mode
  {
    key = 'R',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      timeout_milliseconds = 1000,
      one_shot = false,
    },
  },
  { key = ' ', mods = 'LEADER', action = wezterm.action.QuickSelect },
}

local key_tables = {
  resize_pane = {
    { key = 'h', action = resize_pane('h') },
    { key = 'j', action = resize_pane('j') },
    { key = 'k', action = resize_pane('k') },
    { key = 'l', action = resize_pane('l') },
  },
}

return {
  color_scheme = color_scheme_name,
  window_decorations = 'RESIZE',
  window_background_opacity = opacity,
  macos_window_background_blur = 20,
  -- background = {
  --   {
  --     -- source = { File = os.getenv('HOME') .. '/.config/wezterm/color.jpg' },
  --     -- source = { File = os.getenv('HOME') .. '/.config/wezterm/leaf.jpg' },
  --     source = { File = os.getenv('HOME') .. '/.config/wezterm/fish.gif' },
  --     hsb = { brightness = 0.1 },
  --     horizontal_align = 'Center',
  --     vertical_align = 'Middle',
  --   },
  -- },
  line_height = 1.3,
  -- font
  font = wezterm.font_with_fallback(
    { 'JetBrainsMono Nerd Font Propo', 'UDEV Gothic 35NFLG', 'Symbols Nerd Font Mono', 'SF Pro' },
    { weight = 'Regular', style = 'Normal', stretch = 'Normal' }),
  font_size = 12.0,
  font_rules = {
    -- only bold
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font_with_fallback(
        { 'JetBrainsMono Nerd Font Propo', 'UDEV Gothic 35NFLG', 'Symbols Nerd Font Mono', 'SF Pro' },
        { weight = 'Bold', style = 'Normal', stretch = 'Normal' }
      ),
    },
    -- only italic
    {
      intensity = 'Normal',
      italic = true,
      font = wezterm.font_with_fallback(
        { 'JetBrainsMono Nerd Font Propo', 'UDEV Gothic 35NFLG', 'Symbols Nerd Font Mono', 'SF Pro' },
        { weight = 'Regular', style = 'Italic', stretch = 'Normal' }),
    },
    -- bold and italic
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font_with_fallback(
        { 'JetBrainsMono Nerd Font Propo', 'UDEV Gothic 35NFLG', 'Symbols Nerd Font Mono', 'SF Pro' },
        { weight = 'Bold', style = 'Italic', stretch = 'Normal' }),
    },
  },
  -- tab bar
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  show_tab_index_in_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  show_tabs_in_tab_bar = true,
  tab_max_width = 30,
  tab_bar_at_bottom = false,
  -- cursor
  animation_fps = 120,
  cursor_blink_ease_in = 'EaseOut',
  cursor_blink_ease_out = 'EaseOut',
  cursor_thickness = 0.1,
  default_cursor_style = 'BlinkingBlock',
  -- underline
  underline_position = -5,
  underline_thickness = 2.0,
  -- command palette
  command_palette_fg_color = color_palette.text,
  command_palette_bg_color = color_palette.surface0,
  -- keys
  leader = leader,
  keys = keys,
  key_tables = key_tables,

  quick_select_patterns = { [[\w\S*]] },
  inactive_pane_hsb = {
    brightness = 0.65,
    saturation = 0.9,
  },
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
