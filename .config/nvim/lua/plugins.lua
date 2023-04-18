vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	--
	-- THEME
	--
	-- color theme
	use { 'catppuccin/nvim', as = 'catppuccin' }
	-- syntax highlight
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}
	-- sticky header
	use 'nvim-treesitter/nvim-treesitter-context'
	-- visualize indent
	use 'lukas-reineke/indent-blankline.nvim'
	-- tab bar
	use 'akinsho/bufferline.nvim'
	-- status bar
	use 'nvim-lualine/lualine.nvim'
	-- icons
	use 'kyazdani42/nvim-web-devicons'

	-- editor
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'jeetsukumaran/vim-indentwise'
	use 'nathanaelkane/vim-indent-guides'
	use 'ntpeters/vim-better-whitespace'
	use 'jiangmiao/auto-pairs'
	-- fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, }
	use 'lambdalisue/fern.vim'
	use 'lambdalisue/nerdfont.vim'
	use 'lambdalisue/fern-renderer-nerdfont.vim'
	use 'ron-rs/ron.vim'
	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'
	use 'easymotion/vim-easymotion'
	use 'andrewradev/linediff.vim'
	use 'neoclide/jsonc.vim'
	use 'rust-lang/rust.vim'
	use 'jtdowney/vimux-cargo'
	use 'sunjon/shade.nvim'

	-- Git
	use 'airblade/vim-gitgutter'

	-- test
	use 'vim-test/vim-test'
	use 'tpope/vim-dispatch'

	-- tmux
	use 'christoomey/vim-tmux-navigator'
	use 'preservim/vimux'
	use 'benmills/vimux-golang'

	--
	-- LANGUAGE
	--
	-- LSP
	-- use { 'neoclide/coc.nvim', branch = 'release' }
	use { 'neovim/nvim-lspconfig' }
	use { 'williamboman/mason.nvim' }
	use { 'williamboman/mason-lspconfig.nvim' }
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }
	use { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' }
	use { 'saadparwaiz1/cmp_luasnip' }
	-- Golang
	use 'mattn/vim-goimports'
	-- YAML
	use 'neoclide/coc-yaml'
	-- Protobuf
	use 'rhysd/vim-clang-format'
	-- C#
	use 'OmniSharp/omnisharp-vim'
end)

vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '.config/nvim/**/*.lua',
	command = 'source <afile> | PackerCompile',
})
