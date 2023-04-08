local m = vim.keymap

local telescope = require('telescope.builtin')

m.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })
m.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
m.set('n', '<Space>bd', ':bd<CR>', { silent = true })
m.set('n', '<Space>tt', ':CocCommand go.test.toggle<CR>', { silent = true })
m.set('n', '<Space>sf', telescope.find_files, { silent = true })
m.set('n', '<Space>sb', telescope.buffers, { silent = true })
m.set('n', '<Space>rg', telescope.live_grep, { silent = true })
m.set('x', '<Space>ff', '<Plug>(coc-format-selected)', { silent = true })
m.set('n', '<Space>ff', ':Format<CR>', { silent = true })
m.set('n', '<Space>ft', 'Fern -drawer -reveal=%<CR>', { silent = true })
m.set('v', '<C-a>', ':s/\\%V-\\=\\d\\+/\\=submatch(0)+1/g<CR>')
m.set('v', '<C-x>', ':s/\\%V-\\=\\d\\+/\\=submatch(0)-1/g<CR>')
