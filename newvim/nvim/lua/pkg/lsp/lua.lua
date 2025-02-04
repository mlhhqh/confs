local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("lazydev").setup({
	debug = false,
	library = {
		"nvim-cmp/lua/cmp/types",
	},
	enabled = true,
})
require('lspconfig').lua_ls.setup {
	capabilities = capabilities,
}
