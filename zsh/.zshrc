ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-~/.zsh}

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
source ${ZSH_CONFIG_DIR}/eza.zsh
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
  echo "return '$wezterm_color_scheme'" >$XDG_CONFIG_HOME/wezterm/theme.lua
}

flavour-switch 'macchiato'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"
