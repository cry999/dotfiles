vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#414559' })
vim.api.nvim_create_augroup('CursorLine', {})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter', 'BufEnter', 'FocusGained' }, {
	group = 'CursorLine',
	pattern = '*',
	callback = function()
		vim.opt_local.cursorline = true
	end
})
vim.api.nvim_create_autocmd({ 'VimLeave', 'WinLeave', 'BufWinLeave', 'BufLeave', 'FocusLost' }, {
	group = 'CursorLine',
	pattern = '*',
	callback = function()
		vim.opt_local.cursorline = false
	end
})
