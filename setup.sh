#!/usr/bin/env bash

HERE=$(dirname $(realpath $0))

function check_command() {
  if ! command -v "$1" &> /dev/null; then
      echo "$1 is not installed. Please install it first."
      exit 1
  fi
}

check_command stow
check_command git

envsubst <./btop/.config/btop/_btop.conf >~/.config/btop/btop.conf

# build starship toml
for theme in "latte" "frappe" "macchiato" "mocha"; do
  echo "palette = 'catppuccin_$theme'" >./starship/.config/starship/starship.$theme.toml
  cat ./starship/.config/starship/starship.toml >>./starship/.config/starship/starship.$theme.toml
done

stow -R -v -d ${HERE} -t $HOME \
  aerospace \
  bat       \
  btop      \
  git       \
  homebrew  \
  lazygit   \
  nvim      \
  starship  \
  tmux      \
  wezterm   \
  yazi      \
  zsh

function is_gitconfig_included() {
  git config --global --get-all include.path | grep -q "$1"
}

git_config_extensions=(
  "~/.config/git/delta.gitconfig"
  "~/.config/git/alias.gitconfig"
)

for extension in "${git_config_extensions[@]}"; do
  if ! is_gitconfig_included "$extension"; then
    git config --global --add include.path "$extension"
  fi
done

if [ ! -d ~/.config/delta/themes ]; then
  git clone https://github.com/catppuccin/delta.git ~/.config/delta/themes
else
  pushd ~/.config/delta/themes
  git pull --all -p
  popd
fi
