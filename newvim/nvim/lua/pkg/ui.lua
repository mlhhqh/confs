-- wrap
local function wrap()
	vim.wo.wrap = true
	vim.wo.linebreak = true
	vim.o.wrap = true
	vim.opt.breakindent = true
	vim.opt.showbreak = "↪ "
end
local function linenumbers()
	-- line numbers
	vim.opt.number = true
	vim.opt.relativenumber = true
end
local function my_colorscheme()
	vim.o.termguicolors = true
	vim.o.background = "dark"
	vim.o.cursorline = true
	vim.o.cursorcolumn = true
	-- vim.cmd("colorscheme onedark")
end
function RunSelectedTextAsCode()
	local vstart = vim.fn.getpos("'<")

	local vend = vim.fn.getpos("'>")

	local line_start = vstart[2]
	local line_end = vend[2]

	-- or use api.nvim_buf_get_lines
	local lines = vim.fn.getline(line_start, line_end)

	if type(lines) == "string[]" then
		local code = table.concat(lines, "\n")
		vim.cmd(":lua " .. code)
	end
end

vim.api.nvim_create_user_command("RunSelectedTextAsCode", function(_)
	RunSelectedTextAsCode()
end, { range = true })

require("inlay-hints").setup()

wrap()
linenumbers()
my_colorscheme()

--vim.cmd("colorscheme vague")

require("lsp_lines").setup()
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})
