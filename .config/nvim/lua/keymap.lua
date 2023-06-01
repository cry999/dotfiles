local m = vim.keymap

local telescope = require('telescope.builtin')
local nvimtree = require('nvim-tree')

m.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })
m.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
m.set('n', '<Space>bd', ':bd<CR>', { silent = true })
-- m.set('n', '<Space>tt', ':CocCommand go.test.toggle<CR>', { silent = true })
m.set('n', '<Space>sf', telescope.find_files, { silent = true })
m.set('n', '<Space>sb', telescope.buffers, { silent = true })
m.set('n', '<Space>rg', telescope.live_grep, { silent = true })
-- m.set('x', '<Space>ff', '<Plug>(coc-format-selected)', { silent = true })
-- m.set('n', '<Space>ff', ':Format<CR>', { silent = true })
m.set('n', '<Space>ft', ':NvimTreeToggle<CR>', { silent = true })
m.set('v', '<C-a>', ':s/\\%V-\\=\\d\\+/\\=submatch(0)+1/g<CR>')
m.set('v', '<C-x>', ':s/\\%V-\\=\\d\\+/\\=submatch(0)-1/g<CR>')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('i', '<C-enter>', 'copilot#Accept("\\<CR>")', { silent = true, script = true, expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>ff', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
