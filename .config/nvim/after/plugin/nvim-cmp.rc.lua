local ok, cmp = pcall(require, 'cmp')
if not ok then return end
local ok, luasnip = pcall(require, 'luasnip')
if not ok then return end

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.complete(),
		['<ESC>'] = cmp.mapping.close(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
}
