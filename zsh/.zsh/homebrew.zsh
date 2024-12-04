HOMEBREW_PREFIX=/opt/homebrew
if [ $(uname) = "Linux" ]; then
  HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
fi
brew_wrap="$HOMEBREW_PREFIX/etc/brew-wrap"
if [ -f $brew_wrap ]; then
	source $brew_wrap
fi

export HOMEBREW_BUNDLE_FILE="$HOME/.config/Brewfile"
export HOMEBREW_BREWFILE_EDITOR="nvim"
export PATH=$PATH:/usr/local/sbin
export PATH=$HOMEBREW_PREFIX/bin:$PATH
