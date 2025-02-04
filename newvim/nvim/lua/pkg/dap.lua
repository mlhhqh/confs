-- reset dap ui
-- require("dapui").toggle({ reset = true })
--
--
--
--
--
--
require("dapui").setup({
	mappings = {},
	force_buffers = true,
	element_mappings = { close = { 'q', '<Esc>' } },
	floating = {
		max_height = nil,
		max_width = nil,
		mappings = { close = { 'q', '<Esc>' } },
		border = { enable = true, focusable = true, highlight = 'Normal' },
	},
	render = { show_on = 'never', indent = 2 },
	border = { enable = true, focusable = true, highlight = 'Normal' },
	icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
	controls = {
		enabled = true,
		element = 'repl',
		icons = {
			pause = '',
			play = '',
			step_into = '',
			step_over = '', -- Updated icon for step over
			step_out = '',
			step_back = '',
			run_last = '',
			terminate = '',
			disconnect = '',
		},
	},
	expand_lines = true,
	layouts = {
		{
			elements = {
				{ id = 'breakpoints', size = 0.33 },
				{ id = 'watches',     size = 0.33 },
				{ id = 'scopes',      size = 0.33 },
			},
			position = 'left',
			size = 30,
		},
		{
			elements = {
				-- { id = "console", size = 0.5 },
				{ id = "repl", size = 1.0 },

			},
			position = 'bottom',
			size = 10,
		},
	},
})

local function registerListeners()
	local listener = require('dap').listeners
	listener.after.event_initialized['dapui_config'] = function()
		require('dapui').open()
	end
	listener.before.event_terminated['dapui_config'] = function()
		require('dapui').close()
	end
	listener.before.event_exited['dapui_config'] = function()
		require('dapui').close()
	end
end

registerListeners()

-- REPL completions
require('cmp').setup({
	enabled = true,
	-- enabled = function()
	-- 	return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
	-- end,
})
require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
	sources = {
		{ name = 'dap' },
	},
})
require("nvim-dap-virtual-text").setup(
	{
		commented = true,
		enable_commands = true,
		all_frames = true,
	})
require('nvim-dap-repl-highlights').setup()
