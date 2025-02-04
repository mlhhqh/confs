local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').gopls.setup {
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- capabilities = capabilities,
	settings = {
		gopls = {
			semanticTokens = true,
			usePlaceholders = true,
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	},
}
