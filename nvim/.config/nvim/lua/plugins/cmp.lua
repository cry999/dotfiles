---@diagnostic disable-next-line: deprecated
local get_buf_option = vim.api.nvim_buf_get_option_value or vim.api.nvim_buf_get_option

local has_words_before = function()
  if get_buf_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local has_copilot = function()
  if get_buf_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
      "hrsh7th/cmp-emoji",
      opts = { option = { insert = true } },
      config = function(_, opts)
        require("cmp_emoji").option(_, opts)
      end
    },
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      version = "v2.*",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function() require("copilot_cmp").setup() end,
    }
  },
  event = "InsertEnter",
  opts = function()
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    return {
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item(has_copilot() and { behavior = cmp.SelectBehavior.Select } or {})
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' })
      },
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          priority = 1000,
          option = {
            markdown_oxide = {
              keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
            },
          },
        },
        { name = "copilot", priority = 800 },
        { name = "luasnip", priority = 750 },
        { name = "buffer",  priority = 500 },
        { name = "emoji",   priority = 300 },
        { name = "path",    priority = 250 },
        -- { name = "obsidian",      priority = 200 },
        -- { name = "obsidian_new",  priority = 200 },
        -- { name = "obsidian_tags", priority = 200 },
      }),
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          col_offset = -3,
          side_padding = 0,
          zindex = 1001,
          max_width = 50,
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          zindex = 1000,
          max_width = 50,
        }),
      },
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            preset = 'codicons',
            ellipsis_char = "...",
            symbol_map = {
              Text = "󰉿 ",
              Method = "󰆧 ",
              Function = "󰊕 ",
              Constructor = " ",
              Field = "󰜢 ",
              Variable = "󰀫 ",
              Class = "󰠱 ",
              Interface = " ",
              Module = " ",
              Property = "󰜢 ",
              Unit = "󰑭 ",
              Value = "󰎠 ",
              Enum = " ",
              Keyword = "󰌋 ",
              Snippet = " ",
              Color = "󰏘 ",
              File = "󰈙 ",
              Reference = "󰈇 ",
              Folder = "󰉋 ",
              EnumMember = " ",
              Constant = "󰏿 ",
              Struct = "󰙅 ",
              Event = " ",
              Operator = "󰆕 ",
              Copilot = " ",
              TypeParameter = " ",
            },
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          if #kind.abbr > 50 then
            kind.abbr = kind.abbr:sub(1, 50) .. "..."
          end
          kind.menu = ""
          return kind
        end,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    }
  end,
}
