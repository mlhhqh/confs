require("autoclose").setup({})

local twilight = require("twilight")
twilight.setup({})
--twilight.enable()

vim.keymap.set("i", "jk", "<Esc>")

vim.wo.relativenumber = true
vim.o.cmdheight = 0
vim.cmd.colorscheme("oxocarbon")
vim.opt.linebreak = true
vim.opt.breakindent = true
--vim.cmd.colorscheme("material-deep-ocean")

local outline = require("outline")
outline.setup({
	wrap = true
})

local cmp = require('cmp')

local cmp_kinds = {
	Text = '  ',
	Method = '  ',
	Function = '  ',
	Constructor = '  ',
	Field = '  ',
	Variable = '  ',
	Class = '  ',
	Interface = '  ',
	Module = '  ',
	Property = '  ',
	Unit = '  ',
	Value = '  ',
	Enum = '  ',
	Keyword = '  ',
	Snippet = '  ',
	Color = '  ',
	File = '  ',
	Reference = '  ',
	Folder = '  ',
	EnumMember = '  ',
	Constant = '  ',
	Struct = '  ',
	Event = '  ',
	Operator = '  ',
	TypeParameter = '  ',
}
cmp.setup({
	formatting = {
		fields = { "kind", "abbr" },
		format = function(_, vim_item)
			vim_item.kind = cmp_kinds[vim_item.kind] or ""
			return vim_item
		end,
	},
	snippet = {
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
		})
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-c>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' }, })
})

-- https://github.com/neovide/neovide/issues/1993
vim.cmd "highlight! BorderBG guibg=NONE guifg=#3a86ff"
