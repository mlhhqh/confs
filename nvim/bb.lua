local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			'git',
			'clone',
			"--filter=blob:none",
			'https://github.com/lewis6991/pckr.nvim',
			pckr_path
		})
	end

	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add {
{"folke/tokyonight.nvim"},
{"sindrets/diffview.nvim"},
{"NeogitOrg/neogit"},
{"rachartier/tiny-inline-diagnostic.nvim"},
{"rgroli/other.nvim"},
{"lewis6991/gitsigns.nvim"},
{"chentoast/marks.nvim"},
	{ "nvim-lua/plenary.nvim" },
	{ "Wansmer/treesj" },
	{ "ThePrimeagen/refactoring.nvim" },
	{ "marko-cerovac/material.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "xiantang/darcula-dark.nvim" },
	{ "AlphaTechnolog/onedarker.nvim" },
	{ "benlubas/molten-nvim" },
	{ "folke/zen-mode.nvim" },
	{ "folke/twilight.nvim" },
	{ "b0o/SchemaStore.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "rcarriga/cmp-dap" },
	{ "leoluz/nvim-dap-go" },
	{ "folke/lazydev.nvim" },
	{ "nvim-neotest/nvim-nio" },
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "neovim/nvim-lspconfig" },
	{ "ggml-org/llama.vim" },
	{ "Mofiqul/vscode.nvim" },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-vsnip' },
	{ 'hrsh7th/vim-vsnip' },
}

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- set leader to space
vim.g.mapleader = " "

vim.api.nvim_set_keymap('v', '<leader>r', ':lua Run_selected_code()<CR>',
	{ noremap = true, silent = true })

-- In your lua config, add this:
function Run_selected_code()
	local code = vim.fn.getline("'<", "'>")
	local func, err = loadstring(table.concat(code, "\n"))
	if not func then
		print("Error: " .. err)
	else
		func()
	end
end

-- set line numbers
vim.opt.number = true
-- relative
vim.opt.relativenumber = true
--vim.cmd("colorscheme vscode")
--
local cmp = require 'cmp'

cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
		    or require("cmp_dap").is_dap_buffer()
	end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
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
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false, disallow_fuzzy_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require 'lspconfig'.gopls.setup({
	capabilities = capabilities,
	settings = {
		gopls = {
			semanticTokens = true,
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		}
	}
})
require 'lspconfig'.lua_ls.setup({ capabilities = capabilities })

vim.cmd("colorscheme vscode")
vim.cmd("set cmdheight=0")

-- system clipboard
vim.opt.clipboard = "unnamedplus"



require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "" },
	modules = {},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

-- vim.opt.wrap = true
-- vim.opt.linebreak = true
--
-- -- visual wrap (no real line cutting is made)
-- vim.o.wrap = true
-- vim.o.linebreak = true -- breaks by word rather than character

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldmethod = "expr"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

require('dap-go').setup()
require("lazydev").setup()
require("dapui").setup()

-- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
--vim.o.wrap = true
-- vim.o.linebreak = true
-- vim.o.breakindent = true
-- vim.o.showbreak = '>'
-- -- visual wrap (no real line cutting is made)
-- vim.o.wrap = true
-- vim.o.linebreak = true -- breaks by word rather than character
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = ' ' -- Set the leader key to space

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

vim.opt.shell = 'fish'

local twilight = require("twilight")
twilight.setup({})


require('lspconfig').jsonls.setup {
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
}

require("lspconfig").cssls.setup({})
require 'lspconfig'.ts_ls.setup {}



-- require('telescope.builtin').find_files(require('telescope.themes').get_ivy({ winblend = 90 }))
--Telescope find_files theme=ivy layout_config={height=10}
vim.g.neovide_floating_blur_amount_x = 20.0
vim.g.neovide_floating_blur_amount_y = 20.0
vim.g.neovide_floating_corner_radius = 0.6
--vim.g.neovide_transparency = 1
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_speed = 20.0
vim.g.neovide_cursor_vfx_particle_density = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_size = 3.0
vim.g.neovide_cursor_vfx_color = "#f00000"
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0



-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

vim.api.nvim_create_autocmd("BufWritePre", {
	---@diagnostic disable-next-line
	callback = function(args)
		vim.lsp.buf.format()
		---@diagnostic disable-next-line
		vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
		---@diagnostic disable-next-line
		-- vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
	end,
})



vim.cmd([[  hi default link DapUIVariable Normal
  hi default DapUIScope guifg=#00F1F5
  hi default DapUIType guifg=#D484FF
  hi default DapUIDecoration guifg=#00F1F5
  hi default DapUIThread guifg=#A9FF68
  hi default DapUIStoppedThread guifg=#00f1f5
  hi default link DapUIFrameName Normal
  hi default DapUISource guifg=#D484FF
  hi default DapUILineNumber guifg=#00f1f5
  hi default DapUIFloatBorder guifg=#00F1F5
  hi default DapUIWatchesHeader guifg=#00F1F5
  hi default DapUIWatchesEmpty guifg=#F70067
  hi default DapUIWatchesValue guifg=#A9FF68
  hi default DapUIWatchesError guifg=#F70067
  hi default DapUIWatchesFrame guifg=#D484FF
  hi default DapUIBreakpointsPath guifg=#00F1F5
  hi default DapUIBreakpointsInfo guifg=#A9FF68
  hi default DapUIBreakpointsCurrentLine guifg=#A9FF68 gui=bold
  hi default link DapUIBreakpointsLine DapUILineNumber
  ]])

--require("dapui.config").setup({})
--vim.o.background = "light"
-- require("zen-mode").toggle({})

vim.keymap.set('t', 'jk', [[<C-\><C-n>]]) -- no need to escape the '\'
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)

-- set leader to space
vim.g.mapleader = " "

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
	function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

local tsj = require('treesj')
tsj.setup({})

require('refactoring').setup({
	prompt_func_return_type = {
		go = true,
	},
	prompt_func_param_type = {
		go = true,
	},
	printf_statements = {},
	print_var_statements = {},
	show_success_message = true, -- shows a message with information about the refactor on success
	-- i.e. [Refactor] Inlined 3 variable occurrences
})
