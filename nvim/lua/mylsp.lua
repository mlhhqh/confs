local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
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
require'lspconfig'.tsserver.setup{
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte"
  },
}

require'lspconfig'.cssls.setup({
	filetypes = {
		"ts",
		"tsx",
		"js",
		"jsx",
		"svelte"
	}
})

-- Get the runtime directory
vim.keymap.set({ 'n' }, '<C-k>', function()
	require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set('n', '<C-h>',
	function()
		if vim.lsp.inlay_hint.is_enabled(0) then
			vim.lsp.inlay_hint.enable(0, false)
		else
			vim.lsp.inlay_hint.enable(0, true)
		end
	end
)

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
