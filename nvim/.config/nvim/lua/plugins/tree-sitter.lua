return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
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
      highlight = { enable = true, disable = function(_, bufnr) return vim.b[bufnr].large_buf end, additional_vim_regex_highlighting = false },
      ignore_install = { 'org' },
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
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "inside function" },
            ["al"] = { query = "@loop.outer", desc = "around block" },
            ["il"] = { query = "@loop.inner", desc = "inside block" },
            ["aa"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ia"] = { query = "@parameter.inner", desc = "inside parameter" },
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
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
      })
      require("ts_context_commentstring").setup({
        enable_autocmd = true,
        commentary_integration = {},
        languages = {},
        config = {},
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.likec4 = {
        install_info = {
          url = "/Users/takeharakenta/github.com/cry999/tree-sitter-likec4/",
          files = { "src/parser.c" },
          generate_requires_npm = false,
        },
        filetype = "likec4",
      }

      -- associate copilot-chat with markdown
      vim.treesitter.language.register('markdown', { 'copilot-chat' })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 3,
    },
  },
}
