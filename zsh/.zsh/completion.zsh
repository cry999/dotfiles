fpath+=~/.zfunc
fpath+=/usr/local/share/zsh-completions
fpath+=$(brew --prefix)/share/zsh/site-functions
autoload -Uz compinit
compinit
