function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}
function output_separator(){
  # repeat $(($COLUMNS-2)) echo -n "🚀"
  echo -n "  Output 🚀 "
  repeat $(($COLUMNS-13)) echo -n ""
  echo
  echo
}
add-zsh-hook precmd set_win_title
add-zsh-hook preexec output_separator

eval "$(starship init zsh)"
