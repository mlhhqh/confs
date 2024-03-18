require "paq" {
	"savq/paq-nvim", -- Let Paq manage itself
	{ "neovim/nvim-lspconfig",           opts = { inlay_hints = { enabled = true }, } },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'catppuccin/nvim',                 as = 'catpuccin' },
	{ "m4xshen/autoclose.nvim" },
	--{"ms-jpq/coq_nvim"},
	{ "ray-x/lsp_signature.nvim" },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
}
require("autoclose").setup()
vim.g.mapleader = "<Space>"
-- Get the runtime directory
require("lsp").setup()
require "lsp_signature".setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})
vim.keymap.set({ 'n' }, '<C-k>', function()
	require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'n' }, '<Leader>k', function()
	vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })
vim.keymap.set("i", "jk", "<Esc>")
vim.wo.relativenumber = true
vim.o.cmdheight = 0

vim.cmd.colorscheme("catppuccin-mocha")

local cmp = require('cmp')
cmp.setup({
	snippet = {
	},
	window = {
		--completion = cmp.config.window.bordered(),
		--documentation = cmp.config.window.bordered(),
		completion = {
			border = "single",
			padding = "",
			winhighlight = "Normal:CmpNormal",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})
