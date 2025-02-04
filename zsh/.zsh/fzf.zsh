# zinit light Aloxaf/fzf-tab

# TIPS:
# 'wild | exact-match | Items that include `wild`
# 'wild' | exact-match | Items that include `wild` at word boundary
# ^wild | prefix-match | Items that start with `wild`
# wild$ | suffix-match | Items that end with `wild`
# !wild | inverse-match | Items that do not include `wild`
# !^wild | inverse-prefix-match | Items that do not start with `wild`
# !wild$ | inverse-suffix-match | Items that do not end with `wild`
#
# '|' is used to join multiple patterns with OR logic.

# source <(fzf --zsh)

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
# 	fd --hidden --follow --exclude ".git" . "$1"
# }
#
# Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
# 	fd --type d --hidden --follow --exclude ".git" . "$1"
# }
#
# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
# 	local command=$1
# 	shift
#
# 	case "$command" in
# 		cd)					  fzf --preview 'eza -T --color=always {} | head -200'   "$@" ;;
# 		export|unset) fzf --preview "eval 'echo \$'{}"                       "$@" ;;
# 		ssh)					fzf --preview 'dig {}'                                 "$@" ;;
# 		ps)           fzf --preview 'echo {}'                                "$@" ;;
# 		*)						fzf --preview 'bat -n --color=always {}'               "$@" ;;
# 	esac
# }
#
# export FZF_DEFAULT_COMMAND=$(cat <<"EOF"
# ( (type fd > /dev/null) &&
#   fd --type f --hidden --strip-cwd-prefix --exclude '{.git,node_modules}/**' ) \
#   || $find_ignore f -print 2>/dev/null
# EOF
# )
# # export FZF_DEFAULT_OPTS='--info=inline --border --preview="bat -r 1:20 --color=always {}"'
# export FZF_DEFAULT_OPTS=$(cat <<"EOF"
# --multi
# --height=60%
# --select-1
# --exit-0
# --reverse
# --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up
# EOF
# )
# export FZF_CTRL_R_OPTS=$(cat <<"EOF"
# --preview ' echo {} \
#   | awk " { sub(/\s*[0-9]*?\s*/, \"\"); gsub(/\\\\n/, \"\\n\"); print } " \
#   | bat --color=always --language=sh --style=plain
# '
# --preview-window='down,40%,wrap'
# EOF
# )
#
# local find_ignore="find ./ -type d \( -name '.git' -o -name 'node_modules' \) -prune -o -type"
#
# # Setup fzf
# # ---------
# if [[ ! "$PATH" == *$(brew --prefix)/opt/fzf/bin* ]]; then
#   PATH="${PATH:+${PATH}:}$(brew --prefix)/opt/fzf/bin"
# fi
#
# # Auto-completion
# # ---------------
# if [[ $- == *i* ]]; then
#   source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null
# fi
#
# # Key bindings
# # ------------
# source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# See: https://github.com/catppuccin/fzf
# __fzf_theme() {
#   local theme
#   theme=${CATPPUCCIN_FLAVOUR:-macchiato}
#   case "$theme" in
#     latte) 
#       echo -n "--color"
#       echo -n "=bg+:#ccd0da"
#       echo -n ",bg:#eff1f5"
#       echo -n ",spinner:#dc8a78"
#       echo -n ",hl:#d20f39"
#       echo -n ",fg:#4c4f69"
#       echo -n ",header:#d20f39"
#       echo -n ",info:#8839ef"
#       echo -n ",pointer:#dc8a78"
#       echo -n ",marker:#7287fd"
#       echo -n ",fg+:#4c4f69"
#       echo -n ",prompt:#8839ef"
#       echo -n ",hl+:#d20f39"
#       echo -n ",selected-bg:#bcc0cc"
#       ;;
#     frappe) 
#       echo -n "--color"
#       echo -n "=bg+:#414559"
#       echo -n ",bg:#303446"
#       echo -n ",spinner:#f2d5cf"
#       echo -n ",hl:#e78284"
#       echo -n ",fg:#c6d0f5"
#       echo -n ",header:#e78284"
#       echo -n ",info:#ca9ee6"
#       echo -n ",pointer:#f2d5cf"
#       echo -n ",marker:#babbf1"
#       echo -n ",fg+:#c6d0f5"
#       echo -n ",prompt:#ca9ee6"
#       echo -n ",hl+:#e78284"
#       echo -n ",selected-bg:#51576d"
#       ;;
#     macchiato|*) 
#       echo -n "--color"
#       echo -n "=bg+:#363a4f"
#       echo -n ",bg:#24273a"
#       echo -n ",spinner:#f4dbd6"
#       echo -n ",hl:#ed8796"
#       echo -n ",fg:#cad3f5"
#       echo -n ",header:#ed8796"
#       echo -n ",info:#c6a0f6"
#       echo -n ",pointer:#f4dbd6"
#       echo -n ",marker:#b7bdf8"
#       echo -n ",fg+:#cad3f5"
#       echo -n ",prompt:#c6a0f6"
#       echo -n ",hl+:#ed8796"
#       echo -n ",selected-bg:#494d64"
#       ;;
#     mocha) 
#       echo -n "--color"
#       echo -n ",bg+:#313244"
#       echo -n ",bg:#1e1e2e"
#       echo -n ",spinner:#f5e0dc"
#       echo -n ",hl:#f38ba8"
#       echo -n ",fg:#cdd6f4"
#       echo -n ",header:#f38ba8"
#       echo -n ",info:#cba6f7"
#       echo -n ",pointer:#f5e0dc"
#       echo -n ",marker:#b4befe"
#       echo -n ",fg+:#cdd6f4"
#       echo -n ",prompt:#cba6f7"
#       echo -n ",hl+:#f38ba8"
#       echo -n ",selected-bg:#45475a"
#       ;;
#   esac
# }
# export FZF_DEFAULT_COMMAND='fd --type f'
# # TODO: fzf-preview.sh does not support previewing directories.
# # TODO: ctrl-r is example of how to bind a key to a command. bind more useful actions.
# # TODO: fzf-preview.sh does not support hisotory expansion.
# export FZF_DEFAULT_OPTS="$(cat <<'EOF'
# --style full
# --border --padding 1,2
# --border-label 'FZF' --input-label ' Input ' --header-label ' Header '
# --preview ' fzf-preview.sh {} '
# --bind 'result:transform-list-label:
#   if [[ -z "$FZF_QUERY" ]]; then
#     echo " $FZF_MATCH_COUNT items "
#   else
#     echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
#   fi'
# --bind 'focus:transform-preview-label:[[ -n {} ]] && echo "Previewing: [{}]"'
# --bind 'focus:+transform-header:file --brief {} || echo "No file selected"'
# --bind 'ctrl-r:change-list-label( Reloading the list )+reload( sleep 2; git ls-files )'
# --multi
# EOF
# )
# $(__fzf_theme)"
#
