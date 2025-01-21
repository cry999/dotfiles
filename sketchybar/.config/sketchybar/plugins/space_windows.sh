#!/usr/bin/env bash

# aerospace triggers aerospace_workspace_change event.
# See also: https://nikitabobko.github.io/AeroSpace/guide#exec-on-workspace-change-callback

PLUGIN_DIR=$CONFIG_DIR/plugins
DEBUG_FILE=~/.space_windows.log

. $CONFIG_DIR/colors.sh

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk ' { print $1 } ')
AEROSPACE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

function reload_workspace_icon() {
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' ' { gsub(/^ *| *$/, "", $2); print $2 } ')
  if [ -n "$apps" ]; then
    icon_strip=" "
    while read -r app; do
      icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
      echo APP: $app >>$DEBUG_FILE
    done <<<"$apps"
    echo ICON_STRIP: $icon_strip >>$DEBUG_FILE
  fi
  sketchybar \
    --animate sin 10 \
    --set space.$@ label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  reload_workspace_icon $AEROSPACE_PREV_WORKSPACE
  reload_workspace_icon $AEROSPACE_FOCUSED_WORKSPACE

  # enable current workspace space border color
  sketchybar \
    --set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
    label.highlight=true \
    background.border_color=$OVERLAY2

  # disable previous workspace space border color
  sketchybar \
    --set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false \
    label.highlight=false \
    background.border_color=$BAR_BORDER_COLOR

  for i in $AEROSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done
  for i in $AEROSPACE_EMPTY_WORKSPACE; do
    sketchybar --set space.$i display=0
  done
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
fi
