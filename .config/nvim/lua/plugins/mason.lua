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
  },
}
