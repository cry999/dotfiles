#!/usr/bin/env bash

DEBUG_FILE=~/.colors.log

### Catppuccin
THEME="${THEME:-macchiato}"
case "${THEME,,}" in
  latte)
    # 抹茶ラテ風の調整（nvim設定ベース - 最新版）
    declare -A colors=(
      ["TEXT"]="#1F2B1F"
      ["SUBTEXT1"]="#2D3A2D"
      ["SUBTEXT0"]="#3C4B3C"
      ["OVERLAY2"]="#556655"
      ["OVERLAY1"]="#748974"
      ["OVERLAY0"]="#8FA58F"
      ["SURFACE2"]="#A9BEA9"
      ["SURFACE1"]="#C3D7C3"
      ["SURFACE0"]="#D6E6D6"
      ["CRUST"]="#E1EEE1"     # 少し緑が強くなるよう補正
      ["MANTLE"]="#EAF6EA"    # ミルク寄りの明るいグリーン
      ["BASE"]="#EDF9ED"      # やや緑がかった優しい背景
      
      # アクセントカラー（濃く、しっかり主張）
      ["ROSEWATER"]="#E64553" # しっかり赤みがある苺ピンク
      ["FLAMINGO"]="#D83A5E"  # ベリー系レッド
      ["PINK"]="#D33893"      # ビビッドフューシャピンク
      ["MAUVE"]="#894EC0"     # 濃いスミレ紫
      ["RED"]="#C72039"       # 漆赤（うるしあか）風
      ["MAROON"]="#A32442"    # 黒蜜寄りの深紅
      ["PEACH"]="#DD5E00"     # 焼きピーチ系オレンジ
      ["YELLOW"]="#C39B00"    # 金茶・からし色
      ["GREEN"]="#4CA748"     # 抹茶をより濃く！ほうじ茶寄りも感じる
      ["TEAL"]="#268E87"      # 深い抹茶ミント
      ["BLUE"]="#2A7FFF"      # 抹茶に映える鮮やかブルー
      ["SKY"]="#1EA8C8"       # 透き通る深めの青空
      ["SAPPHIRE"]="#0079A6"  # くっきりした藍色
      ["LAVENDER"]="#6B6CD9"  # 濃ラベンダーで安定感ある紫
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
  matcha)
    declare -A colors=(
      ["ROSEWATER"]="#E8D5C4"
      ["FLAMINGO"]="#D4C5A9"
      ["PINK"]="#C9B897"
      ["MAUVE"]="#A8B894"
      ["RED"]="#B85450"
      ["MAROON"]="#A67C6A"
      ["PEACH"]="#C49963"
      ["YELLOW"]="#D4C985"
      ["GREEN"]="#7BA05B"
      ["TEAL"]="#6B9080"
      ["SKY"]="#5A8F7B"
      ["SAPPHIRE"]="#6A8CAF"
      ["BLUE"]="#708090"
      ["LAVENDER"]="#8A9BA8"
      ["TEXT"]="#D4E6D4"
      ["SUBTEXT1"]="#BDD2BD"
      ["SUBTEXT0"]="#A6BEA6"
      ["OVERLAY2"]="#8FA68F"
      ["OVERLAY1"]="#788E78"
      ["OVERLAY0"]="#617661"
      ["SURFACE2"]="#4A5E4A"
      ["SURFACE1"]="#384638"
      ["SURFACE0"]="#2A342A"
      ["BASE"]="#1E2B1E"
      ["MANTLE"]="#182118"
      ["CRUST"]="#0F150F"
    )
    ;;
esac

for key in "${!colors[@]}"; do
  color="${colors[$key]}"
  color="${color/##/0xff}"
  export "${key}"="${color}"
done

export TRANSPARENT=0x00000000

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
