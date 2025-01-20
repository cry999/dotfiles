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

# --- LazyGit ---
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export GIT_EDITR=nvim
export EDITOR=nvim

export PATH="$HOME/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
