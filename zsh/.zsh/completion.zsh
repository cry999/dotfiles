fpath+=~/.zfunc
fpath+=$HOMEBREW_PREFIX/share/zsh-completions
fpath+=$(brew --prefix)/share/zsh/site-functions
autoload -Uz compinit
compinit
