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

stow -R -v -d ${HERE} -t $HOME \
  git      \
  homebrew \
  lazygit  \
  nvim     \
  skhd     \
  starship \
  tmux     \
  wezterm  \
  yabai    \
  zsh

function is_gitconfig_included() {
  git config --global --get-all include.path | grep -q "$1"
}

if ! is_gitconfig_included "~/.config/git/delta.gitconfig"; then
  git config --global --add include.path "~/.config/git/delta.gitconfig"
fi

if [ ! -d ~/.config/delta/themes ]; then
  git clone https://github.com/catppuccin/delta.git ~/.config/delta/themes
else
  pushd ~/.config/delta/themes
  git pull --all -p
  popd
fi
