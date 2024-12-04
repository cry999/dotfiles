ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-~/.zsh}

# load env at first
source ${ZSH_CONFIG_DIR}/env.zsh

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# color
autoload -Uz colors
colors

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

# auto launch tmux

if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  fi
  tmux attach-session -t "$ID"
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"
