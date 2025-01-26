#!/usr/bin/env bash

LOG_FILE=/tmp/sketchybar.log
PLUGIN_DIR="$CONFIG_DIR/plugins"

. "$CONFIG_DIR/colors.sh"
. "$CONFIG_DIR/constants.sh"

__logging() {
  echo "plugins/space.sh: $@" >> $LOG_FILE
}

__logging "SENDER: $SENDER"

if [ "$SENDER" = "init" ] || [ "$SENDER" = "space_change" ] || [ "$SENDER" = "aerospace_workspace_change" ]; then
  # TODO: want to highlight the current space
  __logging "AEROSPACE_FOCUSED_WORKSPACE: $AEROSPACE_FOCUSED_WORKSPACE"
  __logging "AEROSPACE_PREV_WORKSPACE: $AEROSPACE_PREV_WORKSPACE"

  for monitor_id in $(aerospace list-monitors --format '%{monitor-id}'); do
    __logging monitor_id: $monitor_id
    for workspace_id in $(aerospace list-workspaces --monitor $monitor_id); do
      __logging workspace_id: $workspace_id
      label=$(aerospace list-windows --workspace $workspace_id --format '%{app-name}' | xargs -I {} $PLUGIN_DIR/icon_map.sh {})
      space=(
        space="$workspace_id"
        icon.font="JetBrainsMono Nerd Font:Regular:16.0"
        icon.padding_left=10
        icon.padding_right=10
        label="$label"
        label.font="sketchybar-app-font:Regular:16.0"
        label.color=$TEXT
        label.padding_left=10
        label.padding_right=10
        display="$monitor_id"
      )
      if [ "$workspace_id" = "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
        space+=(
          icon="●"
          icon.color=$GREEN
          icon.highlight_color=$GREEN
          background.color=$BLUE
          background.height=$((BACKGROUND_HEIGHT-2*BORDER_WIDTH))
          background.corner_radius=$BORDER_RADIUS
          background.padding_left=$BORDER_WIDTH
          background.padding_right=$BORDER_WIDTH
        )
        if [ "$label" != "" ]; then
          space+=( 
            label.width="dynamic"
          )
        fi
      else
        space+=(
          icon="◯"
          icon.color=$TEXT
          icon.highlight_color=$TEXT
          label.width=0
          background.color=$TRANSPARENT
        )
      fi
      __logging space: "${space[@]}"
      if [ "$SENDER" = "init" ]; then
      sketchybar \
        --add space space.$workspace_id left
      fi
      sketchybar \
        --animate sin 20 \
        --set space.$workspace_id "${space[@]}"
    done
  done
elif [ "$SENDER" = "space_windows_change" ]; then
  __logging "SENDER: $SENDER"
  for monitor_id in $(aerospace list-monitors --format '%{monitor-id}'); do
    __logging monitor_id: $monitor_id
    for workspace_id in $(aerospace list-workspaces --monitor $monitor_id); do
      label=$(aerospace list-windows --workspace $workspace_id --format '%{app-name}' | xargs -I {} $PLUGIN_DIR/icon_map.sh {})
      __logging "label: $label"
      sketchybar \
        --animate sin 20 \
        --set space.$workspace_id label="$label"
    done
  done
fi
