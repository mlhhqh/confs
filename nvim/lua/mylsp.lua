local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
  on_attach = function(client, bufnr)
    require("inlay-hints").on_attach(client, bufnr)
  end,
	settings = {
		gopls = {
			["ui.inlayhint.hints"] = {
				assignVariableTypes = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
				rangeVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				parameterNames = true
			},
		},
	},
})
local neodev = require("neodev")
neodev.setup({})
lspconfig.lua_ls.setup({})
require "lsp_signature".setup({
	bind = false, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = { border = "rounded" }
})
require 'lspconfig'.tsserver.setup {
	filetypes = {
		"javascript",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte"
	},
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.cssls.setup({
	capabilities = capabilities,
	filetypes = {
		"css",
		"ts",
		"tsx",
		"js",
		"jsx",
		"svelte"
	},
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
	end,
})

-- Get the runtime directory
vim.keymap.set({ 'n' }, '<C-k>', function()
	require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })


require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "go", "markdown", "typescript", "javascript" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	illuminate = {
		enable = true
	}
}

-- Disable tsserver, if you have
-- lspconfig.tsserver.setup { ... }
