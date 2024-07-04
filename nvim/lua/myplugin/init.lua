-- Define a function to wrap commands
local function wrap_command(cmd)
	-- Your custom wrapper logic here
	vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, { cmd })
	print("Wrapping command: " .. cmd)
	-- Execute the original command
	vim.api.nvim_command(cmd)
end

-- Create an autocommand group
vim.api.nvim_command('augroup CommandWrapper')
vim.api.nvim_command('autocmd!')

-- Add an autocommand for CmdlineEnter event
vim.api.nvim_command('autocmd CmdlineEnter * lua WrapCommand()')

-- Function to capture and wrap commands
function WrapCommand()
	-- Get the command from the command line
	local cmd = vim.fn.getcmdline()
	-- Call the wrapper function
	wrap_command(cmd)
	-- Clear the command line to avoid re-executing the original command
	vim.api.nvim_command('normal! :<C-u>')
end

-- End the autocommand group
vim.api.nvim_command('augroup END')
