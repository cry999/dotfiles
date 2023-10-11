return {
  "NvChad/nvim-colorizer.lua",
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
  config = function()
    require("colorizer").setup({
      names = false,
    })
  end,
}
