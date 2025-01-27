#!/bin/sh

LOG_FILE="/tmp/sketchybar.log"

__logging() {
  echo "plugins/volume.sh: $@" >> $LOG_FILE
}

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

__logging "SENDER: $SENDER"

if [ "$SENDER" = "volume_change" ]; then
  __loging "INFO: $INFO"
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾 "
    ;;
    [3-5][0-9]) ICON="󰖀 "
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿 "
    ;;
    *) ICON="󰖁 "
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
