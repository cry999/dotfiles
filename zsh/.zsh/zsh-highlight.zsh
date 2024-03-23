# zsh-syntax-highlighting
if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
	export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
fi

zinit ice pick"themes/catppuccin_${CATPPUCCIN_FLAVOUR}-zsh-syntax-highlighting.zsh"
zinit light catppuccin/zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
