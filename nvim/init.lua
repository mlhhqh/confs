require "paq" { "savq/paq-nvim", -- Let Paq manage itself
	{ "neovim/nvim-lspconfig",           opts = { inlay_hints = { enabled = true }, } },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'catppuccin/nvim',                 as = 'catpuccin' },
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
	{ "RRethy/vim-illuminate" },
}

require("myui")
require("mylsp")
require("myllm")
