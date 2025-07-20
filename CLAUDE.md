# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Communication
Please communicate in Japanese (日本語) when interacting with this repository owner.

## Overview

This is a personal dotfiles repository containing configuration files for a macOS development environment. The repository uses GNU Stow for symlink management and includes configurations for terminal tools, editors, window managers, and development utilities.

## Setup Commands

```bash
# Install dotfiles (from remote)
curl -L https://raw.githubusercontent.com/cry999/dotfiles/master/install.sh | bash

# Setup dotfiles (from local repo)
./setup.sh

# Prerequisites check (done automatically by setup.sh)
command -v stow  # GNU Stow is required
command -v git   # Git is required
```

## Architecture

### Stow-based Organization
Each top-level directory represents a "package" that gets stowed to `$HOME`:
- `aerospace/` - AeroSpace window manager config
- `bat/` - Bat (cat replacement) config
- `borders/` - Window borders utility
- `btop/` - System monitor config
- `ghostty/` - Ghostty terminal config
- `git/` - Git configuration and aliases
- `homebrew/` - Homebrew configuration
- `lazygit/` - LazyGit TUI config
- `nvim/` - Neovim configuration (Lazy.nvim-based)
- `sketchybar/` - SketchyBar status bar config
- `starship/` - Starship prompt config (with Catppuccin themes)
- `tmux/` - Tmux configuration
- `wezterm/` - WezTerm terminal config
- `yazi/` - Yazi file manager config
- `zsh/` - Zsh shell configuration

### Key Configuration Details

**Neovim Setup:**
- Uses Lazy.nvim package manager
- Modular plugin structure in `nvim/.config/nvim/lua/plugins/`
- LSP configurations in `nvim/.config/nvim/lua/lsp/`
- Custom options, mappings, and autocmds in separate files
- Includes AI tools (Copilot, CopilotChat, Avante)

**Git Configuration:**
- Modular git config using include.path
- Separate files for delta (diff viewer) and aliases
- Automatic inclusion of git config extensions via setup script

**Shell Configuration:**
- Zsh with modular configuration files
- Includes integrations for: Go, Python, Rust, Kubernetes, Homebrew, FZF
- Uses Starship prompt with theme variants
- Custom aliases, key bindings, and completion setup

**Theme System:**
- Catppuccin theme variants (latte, frappe, macchiato, mocha)
- Starship configs generated per theme
- Delta themes cloned from catppuccin/delta repository

### Directory Structure Patterns
- Configuration files follow XDG Base Directory standard (`.config/`)
- Stow packages mirror the target directory structure from `$HOME`
- Theme-specific files are generated during setup (e.g., starship themes)
- Binary utilities in `zsh/bin/` for custom scripts

### Setup Process Flow
1. Template substitution for btop config using `envsubst`
2. Generation of Catppuccin theme variants for Starship
3. GNU Stow deployment of all packages
4. Git configuration extension setup via `git config --global --add include.path`
5. Catppuccin delta themes clone/update

This dotfiles setup prioritizes modularity, theming consistency, and modern terminal-based development tools.

## Coding Conventions

### Code Style
- **No trailing whitespace**: Files should not contain trailing spaces at line endings
- **Auto-formatting**: Neovim is configured to automatically remove trailing whitespace on save via `TrimTrailingWhitespace` autocmd in `nvim/.config/nvim/lua/autocmds.lua`
- **LSP Configuration**: All LSP servers are configured through mason-lspconfig.nvim handlers to prevent duplicate server instances