local mason = require('mason')

mason.setup {}

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {}

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

mason_lspconfig.setup_handlers {
	function(server_name)
		nvim_lsp[server_name].setup {}
	end,
}

local protocol = require('vim.lsp.protocol')

protocol.CompletionItemKind = {
	'', -- Text
	'', -- Method
	'', -- Function
	'', -- Constructor
	'', -- Field
	'', -- Variable
	'', -- Class
	'ﰮ', -- Interface
	'', -- Module
	'', -- Property
	'', -- Unit
	'', -- Value
	'', -- Enum
	'', -- Keyword
	'﬌', -- Snippet
	'', -- Color
	'', -- File
	'', -- Reference
	'', -- Folder
	'', -- EnumMember
	'', -- Constant
	'', -- Struct
	'', -- Event
	'ﬦ', -- Operator
	'', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.tsserver.setup {
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities
}

nvim_lsp.lua_ls.setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
			},
		},
	},
}

nvim_lsp.gopls.setup {
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	capabilities = capabilities,
}

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '●'
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
