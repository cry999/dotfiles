#!/usr/bin/env bash

LOG_FILE=/tmp/sketchybar.log
PLUGIN_DIR="$CONFIG_DIR/plugins"

. "$CONFIG_DIR/colors.sh"
. "$CONFIG_DIR/constants.sh"

__logging() {
  echo "plugins/space.sh: $@" >> $LOG_FILE
}

local __focused_space=(
  icon.color=${MAUVE}
  icon.highlight_color=${MAUVE}
  background.color=${BLUE}
  background.height=$((BACKGROUND_HEIGHT-2*BORDER_WIDTH))
  background.corner_radius=$BORDER_RADIUS
  background.padding_left=$BORDER_WIDTH
  background.padding_right=$BORDER_WIDTH
)

local __not_focused_space=(
  icon.color=$BLUE
  icon.highlight_color=$BLUE
  label.width=0
  background.color=$TRANSPARENT
)

local __default_space=(
  icon="●"
  icon.font="JetBrainsMono Nerd Font:Regular:16.0"
  icon.padding_left=10
  icon.padding_right=10
  label.font="sketchybar-app-font:Regular:16.0"
  label.color=$TEXT
  label.padding_left=10
  label.padding_right=10
)

__sbar_set() {
  local space=$1
  shift
  __logging "__sbar_set: sketchybar --set $space $@"
  sketchybar \
    --animate sin 10 \
    --set $space "$@"
}

__get_label() {
  local apps=$(aerospace list-windows --workspace $1 --format '%{app-name}')
  __logging "__get_label: APPS($1): ${apps}"
  local label=""
  while read -r app; do [[ -z "$app" ]] || label+=" $(${PLUGIN_DIR}/icon_map.sh "$app")"; done <<<"$apps"
  __logging "__get_label: LABEL($1): ${label}"
  echo $label
}

__focus_space() {
  local label="$(__get_label $1)"
  local space=(${__focused_space[@]})
  if [ "$label" != "" ]; then
    space+=(label="$label" label.width="dynamic")
  fi
  __sbar_set space.$1 "${space[@]}"
}

__unfocus_space() {
  local space=(${__not_focused_space[@]})
  __sbar_set space.$1 "${space[@]}"
}

__logging "SENDER: $SENDER"

case "$SENDER" in
  init)
    local monitor_id workspace_id label
    for monitor_id in $(aerospace list-monitors --format '%{monitor-id}'); do
      for workspace_id in $(aerospace list-workspaces --monitor $monitor_id); do
        if [ "$SENDER" = "init" ]; then sketchybar --add space space.$workspace_id left; fi
        label="$(__get_label $workspace_id)"
        local space=("${__default_space[@]}")
        space+=(space="$workspace_id" label="$label" display="$monitor_id")
        sketchybar --set space.$workspace_id "${space[@]}"

        __unfocus_space $workspace_id
      done
    done
    __focus_space $AEROSPACE_FOCUSED_WORKSPACE
    ;;

  aerospace_workspace_change)
    __unfocus_space $AEROSPACE_PREV_WORKSPACE
    __focus_space $AEROSPACE_FOCUSED_WORKSPACE
    ;;

  space_windows_change)
    local label monitor_id workspace_id
    for monitor_id in $(aerospace list-monitors --format '%{monitor-id}'); do
      for workspace_id in $(aerospace list-workspaces --monitor $monitor_id); do
        label=$(__get_label $workspace_id)
        __sbar_set space.$workspace_id label="$label"
      done
    done
    ;;
esac
# fi
