return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  cond = function()
    return os.execute("security find-generic-password -s openapi.apikey -a neovim -w") == 0
  end,
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "security find-generic-password -s openapi.apikey -a neovim -w",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
