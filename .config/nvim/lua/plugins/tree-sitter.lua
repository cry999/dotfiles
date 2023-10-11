return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-textobjects",
    { "windwp/nvim-ts-autotag", opts = { autotag = { enable_close_on_slash = false } } },
  },
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSBufToggle",
    "TSDisable",
    "TSEnable",
    "TSToggle",
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSModuleInfo",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
  },
  build = ":TSUpdate",
  opts = {
    autotag = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    highlight = { enable = true, disable = function(_, bufnr) return vim.b[bufnr].large_buf end },
    incremental_selection = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["ab"] = { query = "@block.outer", desc = "around block" },
          ["ib"] = { query = "@block.inner", desc = "inside block" },
          ["ac"] = { query = "@class.outer", desc = "around block" },
          ["ic"] = { query = "@class.inner", desc = "inside block" },
          ["a?"] = { query = "@conditional.outer", desc = "around block" },
          ["i?"] = { query = "@conditional.inner", desc = "inside block" },
          ["af"] = { query = "@function.outer", desc = "around block" },
          ["if"] = { query = "@function.inner", desc = "inside block" },
          ["al"] = { query = "@loop.outer", desc = "around block" },
          ["il"] = { query = "@loop.inner", desc = "inside block" },
          ["aa"] = { query = "@parameter.outer", desc = "around block" },
          ["ia"] = { query = "@parameter.inner", desc = "inside block" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]k"] = { query = "@block.outer", desc = "Next block start" },
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
        },
        goto_next_end = {
          ["]K"] = { query = "@block.outer", desc = "Next block end" },
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
        },
        goto_previous_start = {
          ["[k"] = { query = "@block.outer", desc = "Previous block start" },
          ["[f"] = { query = "@function.outer", desc = "Previous function start" },
          ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
        },
        goto_previous_end = {
          ["[K"] = { query = "@block.outer", desc = "Previous block end" },
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [">K"] = { query = "@block.outer", desc = "Swap next block" },
          [">F"] = { query = "@function.outer", desc = "Swap next function" },
          [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
        },
        swap_previous = {
          ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
          ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
          ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
        },
      },
    },
  },
  config = function(_, opts)
    local parsers = require 'nvim-treesitter.parsers'
    function _G.ensure_treesitter_language_installed()
      local lang = parsers.get_buf_lang()
      if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
        vim.schedule_wrap(function()
          vim.cmd("TSInstall " .. lang)
          vim.notify_once("Finished installing tree-sitter plugin for " .. lang, vim.log.levels.INFO)
        end)()
      end
    end

    local groupName = "tree-sitter"
    vim.api.nvim_create_augroup(groupName, {})
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = "*",
      group = groupName,
      command = [[autocmd FileType * :lua ensure_treesitter_language_installed()]],
    })
    require("nvim-treesitter.configs").setup(opts)
  end,
}
