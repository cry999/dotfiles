#!/usr/bin/env bash

DOTFILES_REPO="github.com/cry999/dotfiles"
DOTFILES_DIR="$HOME/$DOTFILES_REPO"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone "https://$DOTFILES_REPO" "$DOTFILES_DIR" || exit 1
fi

pushd "$DOTFILES_DIR" || exit 1
echo "Installing dotfiles..."
./install.sh
