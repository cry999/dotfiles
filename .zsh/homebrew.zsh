brew_wrap="$(brew --prefix)/etc/brew-wrap"
if [ -f $brew_wrap ]; then
	source $brew_wrap
fi

export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"
export HOMEBREW_BREWFILE_EDITOR="nvim"
export PATH=$PATH:/usr/local/sbin
export PATH=/opt/homebrew/bin:$PATH
