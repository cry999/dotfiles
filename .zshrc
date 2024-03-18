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
source ${ZSH_CONFIG_DIR}/fzf.zsh
source ${ZSH_CONFIG_DIR}/go.zsh
source ${ZSH_CONFIG_DIR}/python.zsh
source ${ZSH_CONFIG_DIR}/rust.zsh
source ${ZSH_CONFIG_DIR}/k8s.zsh
source ${ZSH_CONFIG_DIR}/homebrew.zsh
source ${ZSH_CONFIG_DIR}/aliases.zsh
source ${ZSH_CONFIG_DIR}/bindkey.zsh
source ${ZSH_CONFIG_DIR}/completion.zsh
source ${ZSH_CONFIG_DIR}/opts.zsh
source ${ZSH_CONFIG_DIR}/starship.zsh
source ${ZSH_CONFIG_DIR}/zsh-highlight.zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"
