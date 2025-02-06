local wezterm = require('wezterm');
local mux = wezterm.mux

-- load dynamic configuraitons
local ok_opacity, opacity = pcall(require, 'setting.opacity')
if not ok_opacity then opacity = 1 end
local ok_theme, color_scheme_name = pcall(require, 'setting.theme')
if not ok_theme then color_scheme_name = 'Catppuccin Macchiato' end

-- See: https://github.com/catppuccin/wezterm/blob/main/plugin/init.lua
local colors = require('mycolors')
local color_palette = colors.palettes[color_scheme_name]

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

wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      window:perform_action(wezterm.action.SetPaneZoomState(true), pane)
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.SetPaneZoomState(false), pane)
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      window:perform_action(wezterm.action.SetPaneZoomState(false), pane)
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

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

local DECORATE_MODE = {
  NORMAL = {
    { Background = { Color = color_palette.blue } },
    { Foreground = { Color = colors.opacity_color(color_palette.base, opacity) } },
    { Text = '   NORMAL ' },
  },
  resize_pane = {
    { Background = { Color = colors.opacity_color(color_palette.red, opacity) } },
    { Foreground = { Color = colors.opacity_color(color_palette.base, opacity) } },
    { Text = '  RESIZE ' },
  },
}

wezterm.on('update-status', function(window, _)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = color_palette.text } },
    { Background = { Color = colors.opacity_color(color_palette.surface0, opacity) } },
    { Text = wezterm.pad_left('', window:active_tab():get_size().cols) },
  }))
  local mode = window:active_key_table() or 'NORMAL'
  window:set_left_status(wezterm.format(DECORATE_MODE[mode]))
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
---@return table
local function decorate_tab(tab, fg)
  -- TODO: get max_width from config
  local pane = tab.active_pane
  ---@diagnostic disable-next-line: undefined-field
  local proc = pane.foreground_process_name
  local icon, procname = proc_icon(basename(proc))

  -- local seps = { left = '', div = '▐▌', right = '▐▌' }
  -- local seps = { left = '▌', div = '▐▌', right = ' ' }
  local seps = { left = '▌', div = ' ', right = ' ' }
  if tab.is_active then
    -- seps.div = ''
    -- seps.right = ''
  end

  local bg = colors.opacity_color(tab.is_active and color_palette.base or color_palette.surface0, opacity)

  local color_attrs = {
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
  }
  if tab.is_active then
    color_attrs = {
      { Background = { Color = bg } },
      { Foreground = { Color = fg } },
      { Attribute = { Italic = true } },
    }
  end
  local index_attrs = {
    { Text = seps.left .. ' ' .. (tab.tab_index + 1) .. ' ' },
  }
  local title_attrs = {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = ' ' .. icon .. procname .. '  ' .. tidy_pane_title(pane.title) .. ' ' },
  }

  local attributes = {
    'ResetAttributes',
  }
  for _, attr in ipairs(color_attrs) do
    table.insert(attributes, attr)
  end
  for _, attr in ipairs(index_attrs) do
    table.insert(attributes, attr)
  end
  table.insert(attributes, { Text = seps.div })
  for _, attr in ipairs(title_attrs) do
    table.insert(attributes, attr)
  end
  table.insert(attributes, { Text = seps.right })

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
    if tab.is_active then
      return decorate_tab(tab, color_palette.blue)
    end

    return decorate_tab(tab, color_palette.surface2)
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

---resize_pane
---@param key string
---@param step? integer
---@return table
local function resize_pane(key, step)
  return wezterm.action_callback(function(window, pane)
    if is_vim(pane) then
      window:perform_action({ SendKey = { key = key, mods = 'CTRL|SHIFT' } }, pane)
    else
      window:perform_action({ AdjustPaneSize = { direction_keys[key], step or 5 } }, pane)
    end
  end)
end

---enter_mode
---@param key string
---@param mode string
---@param mods? string
---@return table
local function enter_mode(key, mode, mods)
  return {
    key = key,
    mods = mods or 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = mode,
      timeout_milliseconds = 1000,
      one_shot = false,
    },
  }
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
  --
  enter_mode('H', 'resize_pane'),
  enter_mode('J', 'resize_pane'),
  enter_mode('K', 'resize_pane'),
  enter_mode('L', 'resize_pane'),
  { key = ' ', mods = 'LEADER', action = wezterm.action.QuickSelect },

  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
}

local key_tables = {
  resize_pane = {
    -- small step
    { key = 'h', action = resize_pane('h') },
    { key = 'j', action = resize_pane('j') },
    { key = 'k', action = resize_pane('k') },
    { key = 'l', action = resize_pane('l') },
    -- large step
    { key = 'H', action = resize_pane('h', 15) },
    { key = 'J', action = resize_pane('j', 15) },
    { key = 'K', action = resize_pane('k', 15) },
    { key = 'L', action = resize_pane('l', 15) },
    -- navigate
    navigate_or_send_key('h'),
    navigate_or_send_key('j'),
    navigate_or_send_key('k'),
    navigate_or_send_key('l'),
  },
}

return {
  color_scheme = color_scheme_name,
  window_decorations = 'RESIZE',
  window_background_opacity = opacity,
  macos_window_background_blur = 20,
  line_height = 1.2,
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
  disable_default_key_bindings = true,
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
