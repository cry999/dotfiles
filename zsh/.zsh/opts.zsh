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

###################
# history setting #
###################

# share history between zshs booted in time
setopt share_history

# dont add same command on history
setopt hist_ignore_all_dups

# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt hist_save_no_dups

# When searching for history entries, show only the most recent one.
setopt hist_find_no_dups

# dont add command line starting with space
setopt hist_ignore_space

# trim when add on history
setopt hist_reduce_blanks

# If this is set, zsh sessions will append their history list to the history file, rather than replace it.
setopt append_history

# use high quality wildcard
setopt extended_glob

# separation of words
autoload -Uz select-word-style
select-word-style default

# below is separation
zstyle ':zle:*'        word-chars   " /=;@:{},|"
zstyle ':zle:*'        word-style   unspecified
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors  ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu         no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --all --tree --level=2 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:z:*'  fzf-preview 'eza --all --tree --level=2 --color=always --icons=always $realpath'
