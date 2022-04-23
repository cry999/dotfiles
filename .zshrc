# environment variable
export LANG=ja_JP.UTF-8
# suppress ModuleNotFoundError: No module named 'setuptools._distutils'
export SETUPTOOLS_USE_DISTUTILS=stdlib
# export PYTHONSTARTUP=$HOME/.pythonstartup.py

# color
autoload -Uz colors
colors

# keybind of emacs
bindkey -e

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

#####################################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr $'\uf056'
zstyle ':vcs_info:git:*' stagedstr $'\uf055'
zstyle ':vcs_info:*' formats $'\uf418 %b' $'%c%u'
zstyle ':vcs_info:*' actionformats $'\uf408(%a)%b' $'%c%u'

function _prompt_reset() {
	PROMPT=$'\n'
}

function _prompt_name() {
	local icon=$'\ue77a'
	local bgcolor="129"
	local fgcolor="000"
	if which uname >/dev/null 2>&1; then
		case "$(uname | tr '[A-Z]' '[a-z]')" in
		linux)
			icon=$'\ue712'; bgcolor="015" ;
			case "$([[ -e /etc/os-release ]] && source /etc/os-release; echo $ID)" in
			alpine)   icon=$'\uf300'; bgcolor="159";;
			debian)   icon=$'\uf306'; bgcolor="000"; fgcolor="001";;
			ubuntu)   icon=$'\uf31b'; bgcolor="009";;
			raspbian) icon=$'\uf315'; bgcolor="001";;
			esac ;;
		darwin)  icon=$'\ue711'; bgcolor="165" ;;
		windows) icon=$'\ue70f'; bgcolor="012" ;;
		esac
	fi
	PROMPT=$PROMPT$'%K{'$bgcolor$'}%F{000}\ue0b0%f%k'
	PROMPT=$PROMPT$'%K{'$bgcolor$'}%F{'$fgcolor$'}\ue0b1 %f%k'
	PROMPT=$PROMPT$'%K{'$bgcolor$'}%F{'$fgcolor$'}'"$icon"$' %n@%m%f%k'
	PROMPT=$PROMPT$'%K{'$bgcolor$'}%F{'$fgcolor$'} \ue0b1%f%k'
	PROMPT=$PROMPT$'%K{000}%F{'$bgcolor$'}\ue0b0%f%k'
}

function _prompt_vcs_info_msg() {
	LANG=en_US.UTF-8 vcs_info
	if [[ "${vcs_info_msg_0_}" != "" ]]; then
		PROMPT=$PROMPT$'%K{013}%F{000}\ue0b0%f%k'
		PROMPT=$PROMPT$'%K{013}%F{000}\ue0b1%f%k'
		PROMPT=$PROMPT$'%K{013}%F{000}'" ${vcs_info_msg_0_}"'%f%k'
		[[ "${vcs_info_msg_1_}" != "" ]] && PROMPT=$PROMPT$'%K{013}%F{000}'" ${vcs_info_msg_1_}"'%f%k'
		[[ "${vcs_info_msg_2_}" != "" ]] && PROMPT=$PROMPT$'%K{013}%F{000}'" ${vcs_info_msg_2_}"'%f%k'
		PROMPT=$PROMPT$'%K{013}%F{000}\ue0b1%f%k'
		PROMPT=$PROMPT$'%K{000}%F{013}\ue0b0%f%k'
	fi
}

function _prompt_aws() {
	if [[ -n "$AWS_PROFILE" ]]; then
		PROMPT=$PROMPT$'%K{011}%F{000}\ue0b0%f%k'
		PROMPT=$PROMPT$'%K{011}%F{000}\ue0b1 %f%k'
		PROMPT=$PROMPT$'%K{011}%F{000}\uf0c2 '$AWS_PROFILE$'%f%k'
		PROMPT=$PROMPT$'%K{011}%F{000} \ue0b1%f%k'
		PROMPT=$PROMPT$'%K{000}%F{011}\ue0b0%f%k'
	fi
}

function _prompt_dir() {
	PROMPT=$PROMPT$'%K{011}%F{000}\ue0b0%f%k'
	PROMPT=$PROMPT$'%K{011}%F{000}\ue0b1 %f%k'
	PROMPT=$PROMPT$'%K{011}%F{000}\uf413 %c%f%k'
	PROMPT=$PROMPT$'%K{011}%F{000} \ue0b1%f%k'
	PROMPT=$PROMPT$'%K{000}%F{011}\ue0b0%f%k'
}

function _prompt_finish() {
	PROMPT=$PROMPT$'\n'
	PROMPT=$PROMPT$'\n'
	PROMPT=$PROMPT$'%(?.%K{010}%F{000}.%K{009}%F{000})\ue0b0%f%k'
	PROMPT=$PROMPT$'%(?.%K{010}%F{000}.%K{009}%F{000})\ue0b1%f%k'
	PROMPT=$PROMPT$'%(?.%K{010}%F{000}.%K{009}%F{000})\ue0b1%f%k'
	PROMPT=$PROMPT$'%(?.%K{000}%F{010}.%K{000}%F{009})\ue0b0%f%k '
}

function _update_prompt() {
	_prompt_reset
	_prompt_name
	_prompt_vcs_info_msg
	_prompt_dir
	_prompt_finish
}

add-zsh-hook precmd _update_prompt

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
setopt auto_cd

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
alias l='ls '
alias la='ls -a'
alias ll='ls -al'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# on alias also after sudo
alias sudo='sudo '

# global alias
alias -g L='| less'
alias -g G='| grep'

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
