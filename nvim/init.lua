require "paq" { "savq/paq-nvim", -- Let Paq manage itself
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
	{ "folke/which-key.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "folke/trouble.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "folke/twilight.nvim" },
	{ "marko-cerovac/material.nvim" }
}
local twilight = require("twilight")
twilight.setup({})
twilight.enable()
require("autoclose").setup({})
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
lspconfig.lua_ls.setup({})
require "lsp_signature".setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = { border = "rounded" }
})

-- Get the runtime directory
vim.keymap.set({ 'n' }, '<C-k>', function()
	require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set("i", "jk", "<Esc>")

vim.wo.relativenumber = true
vim.o.cmdheight = 0
vim.cmd.colorscheme("material-deep-ocean")

local cmp = require('cmp')
cmp.setup({
	snippet = {
	},
	window = {
		--completion = cmp.config.window.bordered(),
		--documentation = cmp.config.window.bordered(),
		completion = {
			border = "rounded",
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
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' }, })
})

vim.keymap.set('n', '<C-h>',
	function()
		if vim.lsp.inlay_hint.is_enabled(0) then
			vim.lsp.inlay_hint.enable(0, false)
		else
			vim.lsp.inlay_hint.enable(0, true)
		end
	end
)




vim.g.mapleader = " "
vim.g.maplocalleader = " "

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "go" },
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
