#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

PLUGIN_DIR=$CONFIG_DIR/plugins

if [ "$SENDER" = "front_app_switched" ]; then
  app=(
    label="$INFO"
    icon.background.image="app.$INFO"
    icon.background.image.scale=0.8
  )
  sketchybar --set "$NAME" "${app[@]}"

  # NOTE: Below code may be not required
  AEROSPACE_FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  apps=$(aerospace list-windows --workspace $AEROSPACE_FOCUSED_WORKSPACE | awk -F'|' ' { gsub(/^ *| *$/, "", $2); print $2 } ')
  if [ "$apps" != "" ]; then
    icon_strip=" "
    while read -r app; do
      icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
    done <<<"$apps"
    sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE label="$icon_strip"
  fi
fi
