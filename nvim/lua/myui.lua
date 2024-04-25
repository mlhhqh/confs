require("autoclose").setup({})

local twilight = require("twilight")
twilight.setup({})
--twilight.enable()

vim.keymap.set("i", "jk", "<Esc>")

vim.wo.relativenumber = true
vim.o.cmdheight = 0
vim.cmd.colorscheme("vscode")
vim.opt.linebreak = true
vim.opt.breakindent = true
--vim.cmd.colorscheme("material-deep-ocean")

local outline = require("outline")
outline.setup({})

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
