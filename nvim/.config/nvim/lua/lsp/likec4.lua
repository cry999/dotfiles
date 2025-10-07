local util = require("lspconfig.util")

return {
  cmd = { "/Users/takeharakenta/github.com/cry999/likec4/packages/language-server/bin/likec4-language-server.mjs", "--stdio" },
  filetypes = { "likec4", "c4" },
  root_dir = util.root_pattern(".git"),
  single_file_support = true,
  settings = {},
}

