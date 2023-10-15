ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-~/.zsh}

# load env at first
source ${ZSH_CONFIG_DIR}/env.zsh
# load other config
for f in ${ZSH_CONFIG_DIR}/*.zsh; do
  source $f
done
# load functions at last
for f in ${ZSH_CONFIG_DIR}/functions/*.zsh; do
  source $f
done

# color
autoload -Uz colors
colors

# keybind of emacs
bindkey -v

#####################################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

#######################################################
# PATH

export BAT_THEME="Catppuccin-frappe"

export GIT_EDITR=nvim
export EDITOR=nvim

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="${PATH}:${HOME}/.krew/bin"
alias k=kubectl
