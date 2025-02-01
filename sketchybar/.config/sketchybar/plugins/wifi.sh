#!/usr/bin/env bash

LOG_FILE="/tmp/sketchybar.log"

__logging() {
  echo "plugins/wifi.sh: $@" >> $LOG_FILE
}

__format_speed() {
  speed=$1
  if [ $speed -gt 1024 ]; then
    speed=$(echo "scale=2; $speed / 1024" | bc)
    speed="$speed Mbps"
  else
    speed="$speed kbps"
  fi
  echo $speed
}

case "$SENDER" in
  wifi_change|routine)
    __logging "INFO: $INFO"
    up_down=$(ifstat -i en0 -b 1 1 | tail -n1)
    down=$(echo $up_down | awk ' { print $1 } ' | cut -d'.' -f1)
    up=$(echo $up_down | awk ' { print $2 } ' | cut -d'.' -f1)

    down_formatted=$(__format_speed $down)
    up_formatted=$(__format_speed $up)

    sketchybar \
      --animate sin 20 \
      --set wifi_up label="$up_formatted" \
      --set wifi_down label="$down_formatted"
    ;;
  *)
    __logging "SENDER: $SENDER"
    ;;
esac
