#!/bin/bash

if [ "$SENDER" = "space_change" ]; then
  . "$CONFIG_DIR/colors.sh"
  
  sketchybar --set space.$(aerospace list-workspaces --focused) icon.highlight=true \
                    label.highlight=true \
                    background.border_color=$OVERLAY2
fi
