#!/usr/bin/env bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'

logo=(
  icon=$ICON_APPLE
  icon.font="$FONT:Black:16.0"
  icon.color=$RED
  padding_right=15
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
