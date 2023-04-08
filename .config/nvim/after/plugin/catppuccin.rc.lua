local status, catppuccin = pcall(require, 'catppuccin')
if (not status) then return end

catppuccin.setup({
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	background = {
		dark = "frappe",
	},
	transparent_background = true,
	flavour = 'frappe',
	styles = {
		comments = { 'italic' },
		types = { 'italic', 'bold' },
	},
	integarations = {
		coc_nvim = true,
		gitgutter = true,
		nvimtree = true,
		bufferline = true,
		fern = true,
		treesitter = true,
	},
})
catppuccin.compile()

vim.cmd.colorscheme('catppuccin')
