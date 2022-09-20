# environment variable
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
# suppress ModuleNotFoundError: No module named 'setuptools._distutils'
export SETUPTOOLS_USE_DISTUTILS=stdlib
# export PYTHONSTARTUP=$HOME/.pythonstartup.py
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# color
autoload -Uz colors
colors

# keybind of vim
bindkey -v

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
	print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
		print -P "%F{33} %F{34}Installation successful.%f%b" || \
		print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-bin-gem-node \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light Aloxaf/fzf-tab
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

function zvm_after_select_vi_mode() {
  unset SV_NORMAL
  unset SV_INSERT
  unset SV_VISUAL
  unset SV_REPLACE
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      # Something you want to do...
	  export SV_NORMAL=1
    ;;
    $ZVM_MODE_INSERT)
      # Something you want to do...
	  export SV_INSERT=1
    ;;
    $ZVM_MODE_VISUAL)
      # Something you want to do...
	  export SV_VISUAL=1
    ;;
    $ZVM_MODE_VISUAL_LINE)
      # Something you want to do...
	  export SV_VISUAL=1
    ;;
    $ZVM_MODE_REPLACE)
      # Something you want to do...
	  export SV_REPLACE=1
    ;;
    *)
      export SV_INSERT=1
	;;
  esac
}

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# separation of words
autoload -Uz select-word-style
select-word-style default
# below is separation
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

#####################################################
# completion
fpath+=~/.zfunc
fpath+=/usr/local/share/zsh-completions
autoload -Uz compinit
compinit

# ignore case when completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# not completion current directory after ../
zstyle ':completion:*' igonore-parents parent pwd ..

# completion after sudo
zstyle ':completion:*:sudo:*' command-path /usr/loca/sbin /usr/loca/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# completion process name for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 $reqlpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept'

#####################################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

#####################################################
# option (print japanese name file)
setopt print_eight_bit

# off beep
setopt no_beep

# off flow control
setopt no_flow_control

# off ctrl+d
setopt ignore_eof

# handle after # as comment
setopt interactive_comments

# type only directory name, execute cd
unsetopt auto_cd

# automatically pushd after cd
setopt auto_pushd
# dont add duplicated directory
setopt pushd_ignore_dups

# share history between zshs booted in time
setopt share_history

# dont add same command on history
setopt hist_ignore_all_dups

# dont add command line starting with space
setopt hist_ignore_space

# trim when add on history
setopt hist_reduce_blanks

# use high quality wildcard
setopt extended_glob

#####################################################
# keybind
# when search history(C-r), enable to use * as wildcard
bindkey '^R' history-incremental-pattern-search-backward

#####################################################
# alias

if which uname >/dev/null 2>&1; then
	case $(uname | tr '[A-Z]' '[a-z]') in
		darwin) alias ls='gls --color=auto' ;;
		*)      alias ls='ls --color=auto' ;;
	esac
fi
if [ "$(which vim 2>/dev/null)" = "/usr/bin/vim" ]; then
	alias vim='/usr/local/bin/vim'
fi
alias exa='exa --icons --git-ignore --sort type'
alias ls='exa --no-icons'
alias la='exa -a'
alias ll='exa -al'
alias lt='exa --tree'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias vim='nvim'

# on alias also after sudo
alias sudo='sudo '

# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g F='$(fzf)'

# make brew load no config file in pyenv path
alias brew="env PATH=${PATH/~\/\.pyenv\/shims:/} brew"

# 'C' is copy from stdout to clip board
if which pbcopy >/dev/null 2>&1; then
	# Mac
	alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1; then
	# Linux
	alias -g C='\xsel --input --clipboard'
elif which putclip >/dev/null 2>&1; then
	# Cygwin
	alias -g C='| putclip'
fi

# compiling cpp by c++11
alias g++='g++ -std=c++11'

# vscode
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
#######################################################
# for OS
export CLICOLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--info=inline --border --preview="bat -r 1:20 --color=always {}"'
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=','

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)					 fzf "$@" --preview 'tree -C {} | head -200' ;;
		export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
		ssh)					fzf "$@" --preview 'dig {}' ;;
		*)						fzf "$@" ;;
	esac
}

#######################################################
# PATH

# PYTHON
PYENV_ROOT=~/.pyenv
PYENV_BIN=$PYENV_ROOT/shims

PATH=$PATH:$PYENV_BIN

# GOLANG
if which go >/dev/null 2>&1; then
	export GOPATH=$HOME/go
	export GOBIN=$GOPATH/bin
	PATH=$PATH:$GOPATH/bin
fi

# brew
BREW_PATH=/usr/local/sbin
PATH=$PATH:$BREW_PATH

# dotnet etc...
if [ -x /usr/libexec/path_helper ]; then
	eval $(/usr/libexec/path_helper -s)
fi

###########################################################
#
# pyenv
#
if which pyenv >/dev/null 2>&1; then
	eval "$(pyenv init -)"
	export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
fi

###########################################################
#
# nvm
#
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion

###########################################################
# rust
export PATH="$HOME/.cargo/bin:$PATH"

if which rbenv >/dev/null 2>&1; then
	eval "$(rbenv init -)"
fi

colorlist() {
	for color in {000..015}; do
		print -nP "%F{$color}$color %f"
	done
	printf "\n"
	for color in {016..255}; do
		print -nP "%F{$color}$color %f"
		if [ $(($((color-16))%6)) -eq 5 ]; then
			printf "\n"
		fi
	done
}

# zsh-syntax-highlighting
if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
	export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
fi

# Load starship
eval "$(starship init zsh)"

export GIT_EDITR=nvim
export EDITOR=nvim

[ -f ~/.zshrc.local ] && source ~/.zshrc.local || echo "no .zshrc.local"
