local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function has_copilot()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match "^%s*$" == nil
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
    { "zbirenbaum/copilot-cmp", after = { "copilot.lua" } },
  },
  event = "InsertEnter",
  opts = function()
    local cmp = require("cmp")
    return {
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item(has_copilot() and { behavior = cmp.SelectBehavior.Select } or {})
            return
          end
          -- if luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
          --   return
          -- end
          if has_words_before() then
            cmp.complete()
            return
          end

          fallback()
        end, {'i', 's'}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            return
          end
          -- if luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
          --   return
          -- end
          fallback()
        end, { 'i', 's' })
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "copilot",  priority = 800 },
        -- { name = "luasnip",   priority = 500 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          preset = 'codicons',
          ellipsis_char = "...",
          symbol_map = { Copilot = '' },
        }),
      }
    }
  end,
}
