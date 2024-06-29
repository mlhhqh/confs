require "paq" { "savq/paq-nvim", -- Let Paq manage itself
	{ "neovim/nvim-lspconfig",              opts = { inlay_hints = { enabled = true }, } },
	{ 'nvim-treesitter/nvim-treesitter',    build = ':TSUpdate' },
	{ 'catppuccin/nvim',                    as = 'catpuccin' },
	{ "m4xshen/autoclose.nvim" },
	{ "ray-x/lsp_signature.nvim" },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	--{ "folke/which-key.nvim" },
	{ "folke/trouble.nvim" },
	{ "folke/twilight.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "marko-cerovac/material.nvim" },
	{ "hedyhli/outline.nvim" },
	{ "gsuuon/model.nvim" },
	--{ "RRethy/vim-illuminate" },
	{ "Mofiqul/vscode.nvim" },
	{ "folke/neodev.nvim" },
	{ "xiyaowong/transparent.nvim" },
	--{ "hrsh7th/vim-vsnip" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "MysticalDevil/inlay-hints.nvim" },
	{"https://github.com/onsails/lspkind-nvim"}
}

-- vim.o.guifont = ""

local highlight = {
	"RainbowDelimiterRed",
	"RainbowDelimiterYellow",
	"RainbowDelimiterBlue",
	"RainbowDelimiterOrange",
	"RainbowDelimiterGreen",
	"RainbowDelimiterViolet",
	"RainbowDelimiterCyan",
}

vim.g.rainbow_delimiters = { highlight = highlight }
require("myui")
require("mylsp")
require("myllm")
require("keybindings")
--require('feline').setup()
require("ibl").setup(
	{
		indent = {
		},
		scope = {
			enabled = true,
			show_exact_scope = true,
			highlight = highlight,
			include = {
				node_type = { ["*"] = { "*" } }
			},
			show_start = true,
			show_end = true,
		}
	}
)

local hooks = require "ibl.hooks"
hooks.register(
	hooks.type.SCOPE_HIGHLIGHT,
	hooks.builtin.scope_highlight_from_extmark
)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, "utf-16")
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})



vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=None]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=None]]
vim.cmd("highlight NormalFloat guibg=none")
vim.cmd("highlight FloatBorder guibg=none")

vim.opt.clipboard = 'unnamed'
