local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup({
	options = {
		offsets = {
			{
				filetype = 'NvimTree',
				text = function()
					return ' NvimTree'
				end,
				highlight = 'Directory',
				text_align = 'center',
			},
			{
				filetype = "fern",
				text = function()
					return ' Fern'
				end,
				highlight = 'Directory',
				text_align = 'center',
			},
		},
		separator_style = 'thick',
		highlight = { gui = "underline", guisp = "blue" },
		indicator = {
			style = 'icon'
		},
		show_tab_indicators = true,
		diagnostics = 'coc',
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	}
})
