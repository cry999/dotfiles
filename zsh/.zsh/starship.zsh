# This function sets the terminal title, or wezterm's pane, to the current directory
function set_win_title(){
  echo -ne "\033]0;$(basename "$PWD")\007"
}
add-zsh-hook precmd set_win_title

eval "$(starship init zsh)"
