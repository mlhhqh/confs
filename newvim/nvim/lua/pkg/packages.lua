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
	{ "folke/trouble.nvim",                           requires = { "nvim-lua/plenary.nvim" } },
	{ "folke/tokyonight.nvim",                       as = "tokyonight" },
	{ "folke/which-key.nvim",                        as = "which-key" },
	{ "navarasu/onedark.nvim",                       as = "onedark" },
	{ "olimorris/onedarkpro.nvim",                   as = "onedarkpro" },
	{ "mofiqul/vscode.nvim",                         as = "vscode" },
	{ "rmehri01/onenord.nvim",                       as = "onenord" },
	{ "aktersnurra/no-clown-fiesta.nvim",            as = "no-clown-fiesta" },
	{ "ray-x/aurora", },
	{ "ntbbloodbath/doom-one.nvim",                  as = "doom-one" },
	{ "nyoom-engineering/oxocarbon.nvim",            as = "oxocarbon" },
	{ 'kevinhwang91/nvim-ufo',                       requires = 'kevinhwang91/promise-async' },
	{ "nvim-neo-tree/neo-tree.nvim",                 requires = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" } },
	{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	{ "vague2k/vague.nvim", },
	{ "rcarriga/nvim-dap-ui",                        requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go", "rcarriga/cmp-dap", "theHamsta/nvim-dap-virtual-text", "LiadOz/nvim-dap-repl-highlights" } },
	{ "ggml-org/llama.vim" },
	{ "folke/lazydev.nvim" },
	{ "MysticalDevil/inlay-hints.nvim" },
	{ 'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end, },
	{ "luukvbaal/statuscol.nvim" },
	{ "catppuccin/nvim",         as = "catppuccin",                        name = "catppuccin" },
	{ "ibhagwan/fzf-lua",        requires = "nvim-tree/nvim-web-devicons", dependencies = "nvim-tree/nvim-web-devicons", },
	{ 'navarasu/onedark.nvim' },
	{ "neovim/nvim-lspconfig" },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
}
