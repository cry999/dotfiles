# Neovim Configuration (`nvim/.config/nvim/`)

## Initialization Order

`init.lua`: `options` → Lazy.nvim bootstrap → `plugins/` auto-scan → `autocmds` → `mappings` → `filetype`

## LSP Setup Pattern — Critical

- All LSP servers are configured through mason-lspconfig.nvim **handlers** in `lua/plugins/nvim-lspconfig.lua`
- The handler function auto-discovers `lua/lsp/<server>.lua` via `pcall(require, "lsp." .. server)` and merges with defaults
- To add a new LSP: add to `ensure_installed` in `lua/plugins/mason.lua`, optionally create `lua/lsp/<server>.lua` for custom settings
- **Never** call `lspconfig[server].setup()` outside the handler — this prevents duplicate server instances
- Mason-external servers (e.g., `likec4`) are manually registered in `lspconfig.configs` within `nvim-lspconfig.lua`

## Plugin Structure

Each file in `lua/plugins/` is auto-detected by Lazy.nvim. Create a new file to add a plugin.

## Key Mappings

Organized by category in `lua/mappings/` (`window`, `lsp`, `telescope`, `git`, `copilot`, `editor`, `plugins`). Uses a unified `apply_mappings` helper with which-key integration.

## Custom Filetype

`lua/filetype.lua` maps `.c4` → `likec4`

## Neovim ↔ WezTerm Integration

Bidirectional communication via WezTerm user variables:
- **`IS_NVIM`**: WezTerm detects Neovim and conditionally forwards pane navigation keys
- **`ZEN_MODE`**: Neovim's zen-mode sets this to control WezTerm UI (hide tab bar, enlarge font)
