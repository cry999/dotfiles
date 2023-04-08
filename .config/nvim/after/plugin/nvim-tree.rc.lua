local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then
	return
end

nvimtree.setup {
	view = {
		hide_root_folder = false,
	},
}
