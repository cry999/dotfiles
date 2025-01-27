#!/usr/bin/env bash

. "$CONFIG_DIR/colors.sh"

LOG_FILE="/tmp/sketchybar.log"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  sketchybar --set "$NAME" icon.drawing=off label.drawing=off
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""; COLOR=$YELLOW
  ;;
  [6-8][0-9]) ICON=""; COLOR=$PEACH
  ;;
  [3-5][0-9]) ICON=""; COLOR=$MAROON
  ;;
  [1-2][0-9]) ICON=""; COLOR=$RED
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
  COLOR=$YELLOW
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
sketchybar --set bg_battery background.color=$COLOR
