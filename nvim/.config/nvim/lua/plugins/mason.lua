return {
  "williamboman/mason.nvim",
  cmd = {
    "Mason",
    "MasonIsntall",
    "MasonUnisntall",
    "MasonUnisntallAll",
    "MasonLog",
    "MasonUpdate",
    "MasonUpdateAll",
  },
  opts = {
    ui = {
      height = 0.8,
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
      border = "rounded",
    },
    -- NOTE: rust-analyzer is managed by rustaceanvim
    ensure_installed = {
      -- shell
      "bashls",
      -- lua
      "lua_ls",
      -- go
      "gopls",
      -- python
      "pylsp",
      "black",
      -- typescript
      "ts_ls",
      "prettier",
      -- markdown
      "markdownlint",
      "markdown_oxide",
    },
  },
}
