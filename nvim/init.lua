require "paq" { "savq/paq-nvim", -- Let Paq manage itself
	{ "neovim/nvim-lspconfig",                       opts = { inlay_hints = { enabled = true }, } },
	{ 'nvim-treesitter/nvim-treesitter',             build = ':TSUpdate' },
	{ 'catppuccin/nvim',                             as = 'catpuccin' },
	{ "m4xshen/autoclose.nvim" },
	{ "ray-x/lsp_signature.nvim" },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ "folke/which-key.nvim" },
	{ "folke/twilight.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "hedyhli/outline.nvim" },
	{ "gsuuon/model.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{ "folke/neodev.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "MysticalDevil/inlay-hints.nvim" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "folke/trouble.nvim" },
	{ "Bekaboo/dropbar.nvim" },
	{ "marko-cerovac/material.nvim" }, -- Deep water
	{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "rmagatti/goto-preview" },
	{ "smjonas/inc-rename.nvim" }, -- TODO: Impl
	{ "b0o/SchemaStore.nvim" },
	{ "soulis-1256/eagle.nvim" }
	--{ "rachartier/tiny-inline-diagnostic.nvim" }
}
vim.diagnostic.config({ virtual_text = false })
require("eagle").setup({})
vim.o.mousemoveevent = true
require("dropbar").setup({})
require('trouble').setup {
	-- Other configurations...
	win = {
		-- Customize window options
		wo = {
			wrap = true, -- Enable line wrapping
		}
	}
}
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
require("myui")
require("mylsp")
require("myllm")
require("keybindings")
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


vim.opt.clipboard = 'unnamed'
vim.o.ls = 0

require 'nvim-treesitter.configs'.setup {
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true or false
			include_surrounding_whitespace = true,
		},
	},
}


-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require('lspconfig').jsonls.setup {
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
}
