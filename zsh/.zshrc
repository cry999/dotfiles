export ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-~/.zsh}

# load env at first
source ${ZSH_CONFIG_DIR}/env.zsh

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# color
autoload -Uz colors
colors

source ${ZSH_CONFIG_DIR}/wezterm.zsh
source ${ZSH_CONFIG_DIR}/zinit.zsh
source ${ZSH_CONFIG_DIR}/go.zsh
source ${ZSH_CONFIG_DIR}/python.zsh
source ${ZSH_CONFIG_DIR}/rust.zsh
source ${ZSH_CONFIG_DIR}/k8s.zsh
source ${ZSH_CONFIG_DIR}/homebrew.zsh
source ${ZSH_CONFIG_DIR}/fzf.zsh
source ${ZSH_CONFIG_DIR}/aliases.zsh
source ${ZSH_CONFIG_DIR}/bindkey.zsh
source ${ZSH_CONFIG_DIR}/completion.zsh
source ${ZSH_CONFIG_DIR}/opts.zsh
source ${ZSH_CONFIG_DIR}/starship.zsh
source ${ZSH_CONFIG_DIR}/zsh-highlight.zsh
source ${ZSH_CONFIG_DIR}/zoxide.zsh

function capitalize() {
  echo $1 | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2))}'
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -rf -- "$tmp"
}

function flavour-switch() {
  if [ -z "$1" ]; then
    echo "usage: flavour-switch <catppuccin flavour>"
    return 1
  fi
  # validate flavour
  case "$1" in
    latte) 
      wezterm_color_scheme="Catppuccin Latte"
      ;;
    frappe) 
      wezterm_color_scheme="Catppuccin Frappe"
      ;;
    macchiato) 
      wezterm_color_scheme="Catppuccin Macchiato"
      ;;
    mocha) 
      wezterm_color_scheme="Catppuccin Mocha"
      ;;
    *)
      echo "invalid flavour: $1"
      return 1
  esac
  export CATPPUCCIN_FLAVOUR="$1"
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.$1.toml"
  export BAT_THEME="Catppuccin $(capitalize ${CATPPUCCIN_FLAVOUR})"

  export EZA_COLORS="$(vivid generate catppuccin-$CATPPUCCIN_FLAVOUR)" # default styles
  export EZA_COLORS="${EZA_COLORS}:da=0;38;2;140;170;238" # file's date
  export EZA_COLORS="${EZA_COLORS}:uu=0;38;2;229;200;144" # a user that's you
  export EZA_COLORS="${EZA_COLORS}:uR=0;38;2;231;130;132" # a user that's root
  export EZA_COLORS="${EZA_COLORS}:sn=0;38;2;166;209;137" # file size
  export EZA_COLORS="${EZA_COLORS}:ur=0;38;2;229;200;144" # user's read permission
  export EZA_COLORS="${EZA_COLORS}:uw=0;38;2;229;200;144" # user's write permission
  export EZA_COLORS="${EZA_COLORS}:ux=0;38;2;229;200;144" # user's execute permission

  source ${ZSH_CONFIG_DIR}/zsh-highlight.zsh

  echo "return '$wezterm_color_scheme'" >$XDG_CONFIG_HOME/wezterm/ui/theme.lua
  echo "export CATPPUCCIN_FLAVOUR='$1'" >$ZSH_CONFIG_DIR/_theme.zsh
}

function reload-theme() {
  [[ -e "$ZSH_CONFIG_DIR/_theme.zsh" ]] && source $ZSH_CONFIG_DIR/_theme.zsh
  flavour-switch "${CATPPUCCIN_FLAVOUR:-macchiato}"
}

reload-theme
# reload theme when prompt is shown
add-zsh-hook precmd reload-theme

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"

. <(fzf --zsh)
 # ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=accept-line
