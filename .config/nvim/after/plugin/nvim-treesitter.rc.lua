require('nvim-treesitter.configs').setup({
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = {
			'lua',
		},
		additional_vim_regex_highlighting = false,
	},
})

require('treesitter-context').setup({
	enable = true,
	max_lines = 0,
	trim_scope = 'outer',
	min_window_height = 0,
	patterns = {
		default = {
			'class',
			'function',
			'method',
			'for',
			'while',
			'if',
			'switch',
			'case',
			'interface',
			'struct',
			'enum',
		},
		rust = {
			'impl_item',
		},
		terraform = {
			'block',
			'object_elem',
			'attribute',
		},
		markdown = {
			'section',
		},
		json = {
			'pair',
		},
		typescript = {
			'export_statement',
		},
		yaml = {
			'block_mapping_pair',
		},
	},
})
