# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)					  fzf --preview 'exa -T --color=always {} | head -200'   "$@" ;;
		export|unset) fzf --preview "eval 'echo \$'{}"                       "$@" ;;
		ssh)					fzf --preview 'dig {}'                                 "$@" ;;
		ps)           fzf --preview 'echo {}'                                "$@" ;;
		*)						fzf --preview 'bat -n --color=always {}'               "$@" ;;
	esac
}

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--info=inline --border --preview="bat -r 1:20 --color=always {}"'

# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
  source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
