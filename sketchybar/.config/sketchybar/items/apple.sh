#!/usr/bin/env bash

. "$CONFIG_DIR/constants.sh"

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'

logo=(
  icon=":desktop:"
  icon.font="sketchybar-app-font:Regular:16.0"
  icon.color=$RED
  icon.padding_right=$ICON_PADDING
  icon.padding_left=$ICON_PADDING
  icon.drawing=on
  background.color=$BASE
  background.border_color=$RED
  background.padding_right=15
  label.drawing=off
  click_script='sketchybar --set $NAME popup.drawing=toggle'
  popup.height=35
)

pref=(
  icon=$ICON_PREFERENCES
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

activity=(
  icon=$ICON_ACTIVITY
  label="Activity Monitor"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

sketchybar \
  --add item apple.logo left \
  --set apple.logo "${logo[@]}" \
  \
  --add item apple.pref popup.apple.logo \
  --set apple.pref "${pref[@]}" \
  \
  --add item apple.activity popup.apple.logo \
  --set apple.activity "${activity[@]}"
