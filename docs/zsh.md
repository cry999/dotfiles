# Zsh Configuration (`zsh/`)

## Loading Order

Modular `.zsh` files loaded from `.zshrc` in specific order:
`env` → `wezterm` → `zinit` → `go/rust/k8s` → `homebrew` → `python` → `fzf` → `aliases/bindings` → `starship` → `highlighting`

**Important**: `python.zsh` must load after `homebrew.zsh` because it uses `$HOMEBREW_PREFIX`.

## Plugin Manager

**Zinit** (zdharma-continuum). Key plugins: zsh-autosuggestions, zsh-completions, fzf-tab, zsh-vi-mode.

## Custom Scripts (`zsh/bin/`)

- `gclone`: git clone helper
- `imgcat`: terminal image display
- `note`: date-based notes
- `pretty_pwd`: shortened path for Starship

## Yazi Integration

`y()` function in `.zshrc` integrates Yazi file manager with directory changing.
