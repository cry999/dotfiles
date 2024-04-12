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
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
      border = "rounded",
    },
    -- NOTE: rust-analyzer is managed by rustaceanvim
    ensure_installed = {
      "lua_ls",
      "gopls",
      "pylsp",
      "tsserver",
    },
  },
}
