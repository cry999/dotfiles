export LANG=ja_JP.UTF-8
# export TERM=xterm-256color
# history
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export CLICOLOR=1

if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

function capitalize() {
  echo $1 | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2))}'
}

# --- LazyGit ---
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

export CATPPUCCIN_FLAVOUR="frappe"

export BAT_THEME="Catppuccin $(capitalize ${CATPPUCCIN_FLAVOUR})"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export GIT_EDITR=nvim
export EDITOR=nvim

export EZA_COLORS="$(vivid generate catppuccin-$CATPPUCCIN_FLAVOUR)" # default styles
export EZA_COLORS="${EZA_COLORS}:da=0;38;2;140;170;238" # file's date
export EZA_COLORS="${EZA_COLORS}:uu=0;38;2;229;200;144" # a user that's you
export EZA_COLORS="${EZA_COLORS}:uR=0;38;2;231;130;132" # a user that's root
export EZA_COLORS="${EZA_COLORS}:sn=0;38;2;166;209;137" # file size
export EZA_COLORS="${EZA_COLORS}:ur=0;38;2;229;200;144" # user's read permission
export EZA_COLORS="${EZA_COLORS}:uw=0;38;2;229;200;144" # user's write permission
export EZA_COLORS="${EZA_COLORS}:ux=0;38;2;229;200;144" # user's execute permission

export PATH="$HOME/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
