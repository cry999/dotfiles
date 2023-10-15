fpath+=~/.zfunc
fpath+=/usr/local/share/zsh-completions
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit
compinit

# ignore case when completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# not completion current directory after ../
# zstyle ':completion:*' igonore-parents parent pwd ..

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
# # preview directory's content with exa when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 $reqlpath'
# # switch group using `,` and `.`
# zstyle ':fzf-tab:*' switch-group ',' '.'
# zstyle ':fzf-tab:*' continuous-trigger '/'
# zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept'
