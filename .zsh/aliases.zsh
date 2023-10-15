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
