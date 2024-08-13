local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not vim.uv.fs_stat(pckr_path) then
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
	{ 'nvim-treesitter/nvim-treesitter' },
	{ "neovim/nvim-lspconfig" },
	{ "folke/lazydev.nvim" },
	{ "m4xshen/autoclose.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/vim-vsnip" },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "folke/twilight.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "hedyhli/outline.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
	{ 'nvim-lua/plenary.nvim' },
	{ "gsuuon/model.nvim" },
	{"mfussenegger/nvim-dap"},
	{"nvim-neotest/nvim-nio"},
	{"rcarriga/nvim-dap-ui"},
	{"leoluz/nvim-dap-go"},
}

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

require("lazydev").setup({})

require("lspconfig").lua_ls.setup({})
require("lspconfig").gopls.setup({})

vim.opt.breakindent = true

require("nvim-treesitter.configs").setup({
	modules = {},
	ignore_install = {},
	ensure_installed = { "go", "markdown" },
	sync_install = true,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})


require("autoclose").setup({})
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '>'
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = ' ' -- Set the leader key to space

-- Function to execute selected Lua code
function _G.run_selected_lua()
	local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
	local lines = vim.fn.getline(start_line, end_line)
	local code = table.concat(lines, "\n")
	vim.api.nvim_command('lua ' .. code)
end

-- Keybinding to run the selected code
vim.api.nvim_set_keymap('v', '<leader>r', ':lua run_selected_lua()<CR>', { noremap = true, silent = true })

local cmp = require 'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'vsnip' } })
})

vim.cmd("colorscheme oxocarbon")
vim.cmd("highlight Normal guibg=None")

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


require("twilight").setup()

-- vim.g.lazydev_enabled = true
-- require("twilight").enable()
--

-- Function to create a floating window with the given text
local function create_floating_window(text)
end

local function check_config_file()
	local file_path = vim.fn.expand("%:p")
	local config_dir = os.getenv("XDG_CONFIG_HOME") .. "/nvim"

	if string.match(file_path, "^" .. config_dir) then
		local text = "im a config"
		local buf = vim.api.nvim_create_buf(false, true)
		local width = 40
		local height = 1
		local win_opts = {
			relative = "editor",
			width = width,
			height = height,
			row = (vim.o.lines - height) / 2,
			col = (vim.o.columns - width) / 2,
			style = "minimal"
		}
		local win = vim.api.nvim_open_win(buf, true, win_opts)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
		vim.api.nvim_buf_set_option(buf, 'modifiable', false)
	end
end

local function open_popup()
	check_config_file()
end

vim.api.nvim_create_autocmd('BufNewFile', {
	pattern = "*.lua",
	callback = open_popup,
})


-- Load the plugin

require("myllm")

