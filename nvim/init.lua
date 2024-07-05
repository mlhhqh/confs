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
require("eagle").setup({})

require('lspconfig').jsonls.setup {
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
}


-- ~/.config/nvim/pack/plugins/start/nvim-telescope-cmdhistory/init.lua
local telescope = require('telescope')
local actions = require('telescope.actions')
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config")
local sorters = require("telescope.sorters")
local action_state = require('telescope.actions.state')

-- Function to prompt for a keybinding and set it for the selected command
local function prompt_for_keybinding(command)
	-- Prompt the user to enter a keybinding
	local keybinding = vim.fn.input("Enter keybinding (e.g., <C-m>): ")

	if keybinding == "" then
		print("No keybinding entered.")
		return
	end

	-- Define the path to the Lua keybindings file
	local keybindings_file = vim.fn.expand("~/.config/nvim/lua/keybindings.lua")

	-- Create the Lua command for keybinding and write it to the file
	local keybinding_command = string.format("vim.api.nvim_set_keymap('n', '%s', ':%s<CR>', { noremap = true })\n",
		keybinding, command)
	local file = io.open(keybindings_file, "a")
	if file then
		file:write(keybinding_command)
		file:close()
		print("Keybinding " .. keybinding .. " written to " .. keybindings_file)
	else
		print("Failed to write keybinding to file.")
	end

	print("Wrote?")
	-- Source the Lua file to apply the new keybinding
	-- dofile(keybindings_file)
end

-- Custom Telescope picker for command history
local function command_history_picker()
	local commands = {}
	for i = 1, vim.fn.histnr(':') do
		local cmd = vim.fn.histget(':', -i)
		if cmd ~= "" then
			table.insert(commands, cmd)
		end
	end

	pickers.new({}, {
		prompt_title = 'Command History',
		finder = finders.new_table {
			results = commands
		},
		sorter = sorters.get_generic_fuzzy_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				if selection then
					prompt_for_keybinding(selection[1])
				end
			end)
			return true
		end,
	}):find()
end

-- Create a custom command to invoke the Telescope command history picker
vim.api.nvim_create_user_command('CommandHistoryPicker', command_history_picker, {})

-- Usage: :CommandHistoryPicker
--
require("keybindings")
