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

# separation of words
autoload -Uz select-word-style
select-word-style default

# below is separation
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
