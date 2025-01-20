if which uname >/dev/null 2>&1; then
	case $(uname | tr '[A-Z]' '[a-z]') in
		darwin) alias ls='gls --color=auto' ;;
		*)      alias ls='ls --color=auto' ;;
	esac
fi
alias eza='eza --icons=always --git-ignore --sort type'
alias ls='eza --icons=never'
alias la='eza -a'
alias ll='eza -al'
alias lt='eza --tree'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

function _nvim() {
  if [ ! -z "$1" ] && [ -d "$1" ]; then
    nvim --cmd "cd $1"
  else
    nvim $1
  fi
}

alias v='vi'
alias vi='vim'
alias vim='nvim'
alias nvim='_nvim'

# on alias also after sudo
alias sudo='sudo '

# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g F='$(fzf)'

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

alias zi='__zoxide_zi'
