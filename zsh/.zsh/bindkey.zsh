# keybind of vi
bindkey -v
# when search history(C-r), enable to use * as wildcard
__fzf_history_search() {
  local query
  query=$LBUFFER
  LBUFFER=""
  zle reset-prompt
  LBUFFER=$(
    history -E 1 |
      gsed -e 's/^\s*//g' |
      gsed -e 's/\s\{2,\}/ /g' |
      cut -d' ' -f4- |
      fzf +s --tac +m --query="$query" --prompt="history> " |
      sed -r 's/ *[0-9]*\*? *//'
  )
}
zle -N fzf_history_search __fzf_history_search
bindkey '^R' fzf_history_search
bindkey '^Y' autosuggest-accept
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
