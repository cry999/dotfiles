local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup({
	options = {
		theme = 'catppuccin',
		component_separators = '',
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = {
			{ 'mode', separator = { left = '' }, right_padding = 2 },
		},
		lualine_b = {
			{ 'filetype', icon_only = true, separator = { left = '' } },
			{
				'filename',
				path = 1,
				symbols = {
					modified = ' ', readonly = ' ', unnamed = '...', newfile = ' ',
				}
			},
		},
		lualine_c = { 'diagnostics' },
		lualine_x = {
			{ 'branch', separator = { left = '' } },
			'diff',
		},
		lualine_y = { 'filetype', 'encoding', 'fileformat', 'progress' },
		lualine_z = {
			{ 'location', separator = { right = '' }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { 'filename' },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'location' },
	},
	tabline = {},
	extensions = {},
})
