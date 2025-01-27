#!/usr/bin/env bash

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

PLUGIN_DIR=$CONFIG_DIR/plugins

LOG_FILE="/tmp/sketchybar.log"

__logging() {
  echo "plugins/front_app.sh: $@" >> $LOG_FILE
}

__logging "SENDER: $SENDER"

case "$SENDER" in
  front_app_switched|routine)
    app_name=$(aerospace list-windows --focused --format '%{app-name}' 2>&1)
    if [ "$app_name" = "No window is focused" ]; then
      app_name="-"
      window_title="-"
      icon_background_image_drawing="off"
    else
      window_title=$(aerospace list-windows --focused --format '%{window-title}' 2>&1)
      icon_background_image_drawing="on"
    fi
    name=(
      label="$app_name"
      icon.background.image="app.$app_name"
      icon.background.image.drawing=$icon_background_image_drawing
      icon.background.color=$TRANSPARENT
    )
    sketchybar --set front_app_name "${name[@]}"

    title=(
      label="$window_title"
    )
    sketchybar --set front_app_title "${title[@]}"

    __logging "APP_NAME: $app_name"
    __logging "WINDOW_TITLE: $window_title"
    ;;
  *)
    ;;
esac
