vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
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
	use 'lambdalisue/fern.vim'
	use 'lambdalisue/nerdfont.vim'
	use 'lambdalisue/fern-renderer-nerdfont.vim'
	use 'ron-rs/ron.vim'
	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'
	use 'easymotion/vim-easymotion'
	use 'andrewradev/linediff.vim'
	use 'neoclide/jsonc.vim'
	use 'kyazdani42/nvim-tree.lua'
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
	use { 'neoclide/coc.nvim', branch = 'release' }
	-- Golang
	use 'mattn/vim-goimports'
	-- YAML
	use 'neoclide/coc-yaml'
	-- Protobuf
	use 'rhysd/vim-clang-format'
	-- C#
	use 'OmniSharp/omnisharp-vim'
end)
