return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    scope = {
      include = { node_type = { ["*"] = { "*" } } },
    },
    indent = {
      char = '┋',
    },
    exclude = { filetypes = { "help", "packer", "NvimTree", "Outline", "dashboard" } },
  },
}
