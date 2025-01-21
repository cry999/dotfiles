#!/usr/bin/env bash

DEBUG_FILE=~/.space_windows.log

sketchybar --add event aerospace_workspace_change

BG_COLORS=(
  $RED
  $PEACH
  $YELLOW
  $GREEN
  $SKY
  $BLUE
  $MAUVE
)

echo "BG_COLORS: ${BG_COLORS[@]}" >$DEBUG_FILE
echo "#BG_COLORS: ${#BG_COLORS[@]}" >>$DEBUG_FILE
for monitor_id in $(aerospace list-monitors | awk ' { print $1 } '); do
  for workspace_id in $(aerospace list-workspaces --monitor $monitor_id); do
    BG_INDEX=$((($workspace_id-1)%${#BG_COLORS[@]}))
    BG_COLOR=$((${BG_COLORS[$BG_INDEX]}&0x77ffffff))
    echo "workspace_id: $workspace_id, monitor_id: $monitor_id, BG_COLOR: $BG_COLOR, workspace_id%#BG_COLORS: $BG_INDEX" >>$DEBUG_FILE
    space=(
      space=$workspace_id
      icon=$(($BG_INDEX+1))
      icon.highlight_color=$RED
      icon.padding_left=10
      icon.padding_right=10
      display=$monitor_id
      padding_left=2
      padding_right=2
      label.padding_right=20
      label.color=$OVERLAY2
      label.highlight_color=$ROSEWATER
      label.font="sketchybar-app-font:Regular:16.0"
      label.y_offset=-1
      background.color=$BG_COLOR
      background.border_color=$BACKGROUND_2
      script="$PLUGIN_DIR/space.sh"
    )
    sketchybar \
      --add space space.$workspace_id left \
      --set space.$workspace_id "${space[@]}" \
      --subscribe space.$workspace_id mouse.clicked

    apps=$(
      aerospace list-windows --workspace $workspace_id |
        awk -F'|' '{ gsub(/^ *| *$/, "", $2); print $2 }'
    )
    if [ -n "$apps" ]; then
      icon_strip=" "
      while read -r app
      do
        icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
      done <<< "$apps"
      sketchybar \
        --set space.$workspace_id label="$icon_strip"
    else
      sketchybar \
        --set space.$workspace_id drawing=off
     fi

  done
done

space_creator=(
  icon='􀆊'
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)
sketchybar \
  --add item space_creator left \
  --set space_creator "${space_creator[@]}" \
  --subscribe space_creator aerospace_workspace_change
