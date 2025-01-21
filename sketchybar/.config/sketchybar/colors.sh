#!/usr/bin/env bash

DEBUG_FILE=~/.colors.log

### Catppuccin
export BLACK=0xff181926
export WHITE=0xffcad3f5

THEME="${THEME:-macchiato}"
case "${THEME,,}" in
  latte)
    declare -A colors=(
      ["ROSEWATER"]="#DC8A78"
      ["FLAMINGO"]="#DD7878"
      ["PINK"]="#EA76CB"
      ["MAUVE"]="#8839EF"
      ["RED"]="#D20F39"
      ["MAROON"]="#E64553"
      ["PEACH"]="#FE640B"
      ["YELLOW"]="#DF8E1D"
      ["GREEN"]="#40A02B"
      ["TEAL"]="#179299"
      ["SKY"]="#04A5E5"
      ["SAPPHIRE"]="#209FB5"
      ["BLUE"]="#1E66F5"
      ["LAVENDER"]="#7287FD"
      ["TEXT"]="#4C4F69"
      ["SUBTEXT1"]="#5C5F77"
      ["SUBTEXT0"]="#6C6F85"
      ["OVERLAY2"]="#7C7F93"
      ["OVERLAY1"]="#8C8FA1"
      ["OVERLAY0"]="#9CA0B0"
      ["SURFACE2"]="#ACB0BE"
      ["SURFACE1"]="#BCC0CC"
      ["SURFACE0"]="#CCD0DA"
      ["BASE"]="#EFF1F5"
      ["MANTLE"]="#E6E9EF"
      ["CRUST"]="#DCE0E8"
    )
    ;;
  frappe)
    declare -A colors=(
      ["ROSEWATER"]="#F2D5CF"
      ["FLAMINGO"]="#EEBEBE"
      ["PINK"]="#F4B8E4"
      ["MAUVE"]="#CA9EE6"
      ["RED"]="#E78284"
      ["MAROON"]="#EA999C"
      ["PEACH"]="#EF9F76"
      ["YELLOW"]="#E5C890"
      ["GREEN"]="#A6D189"
      ["TEAL"]="#81C8BE"
      ["SKY"]="#99D1DB"
      ["SAPPHIRE"]="#85C1DC"
      ["BLUE"]="#8CAAEE"
      ["LAVENDER"]="#BABBF1"
      ["TEXT"]="#C6D0F5"
      ["SUBTEXT1"]="#B5BFE2"
      ["SUBTEXT0"]="#A5ADCE"
      ["OVERLAY2"]="#949CBB"
      ["OVERLAY1"]="#838BA7"
      ["OVERLAY0"]="#737994"
      ["SURFACE2"]="#626880"
      ["SURFACE1"]="#51576D"
      ["SURFACE0"]="#414559"
      ["BASE"]="#303446"
      ["MANTLE"]="#292C3C"
      ["CRUST"]="#232634"
    )
    ;;
  macchiato)
    declare -A colors=(
      ["ROSEWATER"]="#F4DBD6"
      ["FLAMINGO"]="#F0C6C6"
      ["PINK"]="#F5BDE6"
      ["MAUVE"]="#C6A0F6"
      ["RED"]="#ED8796"
      ["MAROON"]="#EE99A0"
      ["PEACH"]="#F5A97F"
      ["YELLOW"]="#EED49F"
      ["GREEN"]="#A6DA95"
      ["TEAL"]="#8BD5CA"
      ["SKY"]="#91D7E3"
      ["SAPPHIRE"]="#7DC4E4"
      ["BLUE"]="#8AADF4"
      ["LAVENDER"]="#B7BDF8"
      ["TEXT"]="#CAD3F5"
      ["SUBTEXT1"]="#B8C0E0"
      ["SUBTEXT0"]="#A5ADCB"
      ["OVERLAY2"]="#939AB7"
      ["OVERLAY1"]="#8087A2"
      ["OVERLAY0"]="#6E738D"
      ["SURFACE2"]="#5B6078"
      ["SURFACE1"]="#494D64"
      ["SURFACE0"]="#363A4F"
      ["BASE"]="#24273A"
      ["MANTLE"]="#1E2030"
      ["CRUST"]="#181926"
    )
    ;;
  mocha)
    declare -A colors=(
      ["ROSEWATER"]="#F5E0DC"
      ["FLAMINGO"]="#F2CDCD"
      ["PINK"]="#F5C2E7"
      ["MAUVE"]="#CBA6F7"
      ["RED"]="#F38BA8"
      ["MAROON"]="#EBA0AC"
      ["PEACH"]="#FAB387"
      ["YELLOW"]="#F9E2AF"
      ["GREEN"]="#A6E3A1"
      ["TEAL"]="#94E2D5"
      ["SKY"]="#89DCEB"
      ["SAPPHIRE"]="#74C7EC"
      ["BLUE"]="#89B4FA"
      ["LAVENDER"]="#B4BEFE"
      ["TEXT"]="#CDD6F4"
      ["SUBTEXT1"]="#BAC2DE"
      ["SUBTEXT0"]="#A6ADC8"
      ["OVERLAY2"]="#9399B2"
      ["OVERLAY1"]="#7F849C"
      ["OVERLAY0"]="#6C7086"
      ["SURFACE2"]="#585B70"
      ["SURFACE1"]="#45475A"
      ["SURFACE0"]="#313244"
      ["BASE"]="#1E1E2E"
      ["MANTLE"]="#181825"
      ["CRUST"]="#11111B"
    )
    ;;
esac

for key in "${!colors[@]}"; do
  color="${colors[$key]}"
  color="${color/##/0xff}"
  export "${key}"="${color}"
done

export BATTERY_1=$GREEN
export BATTERY_2=$YELLOW
export BATTERY_3=$PEACH
export BATTERY_4=$MAROON
export BATTERY_5=$RED

# General bar colors
export BAR_COLOR=$BASE
export BAR_BORDER_COLOR=$SURFACE2
export BACKGROUND_1=$SURFACE1
export BACKGROUND_2=$SURFACE2
export ICON_COLOR=$SURFACE0 # Color of all icons
export LABEL_COLOR=$SURFACE0 # Color of all labels
export POPUP_BACKGROUND_COLOR=$BAR_COLOR
export POPUP_BORDER_COLOR=$SURFACE0
export SHADOW_COLOR=$CRUST
