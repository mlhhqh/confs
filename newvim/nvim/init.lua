require("pkg.packages")
require("pkg.cmp")
require("pkg.ui")
require("pkg.dap")
require("pkg.lsp.main")
require("pkg.keybindings")
require("pkg.syntax")

vim.cmd("set nocursorcolumn")
require("neovide")

vim.g.mapleader = " "
require("which-key").setup({})
vim.cmd([[set cmdheight=0]])
vim.cmd("colorscheme tokyonight-night")

-- fold
local function fold()
	vim.opt.foldmethod   = 'expr'
	vim.opt.foldexpr     = 'nvim_treesitter#foldexpr()'
	vim.o.foldcolumn     = '0'
	vim.o.foldlevel      = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable     = true

	vim.keymap.set("n", "yR", require("ufo").openAllFolds)
	vim.keymap.set("n", "yM", require("ufo").closeAllFolds)
	require("ufo").setup({
		enable_get_fold_virt_text = true,
		open_fold_hl_timeout = 100,
		provider_selector = function(_, _, _)
			return { "treesitter", "indent" }
		end,
		preview = {
			win_config = {
				border = "single",
				winblend = 10,
			},
		},
		fold_virt_text_handler = function(virtText, lnum, endLnum, width, _)
			local newVirtText = {}
			local suffix = (" %d  ..."):format(endLnum - lnum)
			local suffixWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - suffixWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if curWidth + chunkWidth < targetWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = vim.fn.strcharpart(chunkText, 0, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						if suffix then
							table.insert(newVirtText, { suffix, "MoreMsg" })
							return newVirtText
						end
						return newVirtText
					end
					curWidth = curWidth + chunkWidth
					break
				end
				curWidth = curWidth + chunkWidth
			end
			if suffix then
				table.insert(newVirtText, { suffix, "MoreMsg" })
			end
			return newVirtText
		end
	})
end

fold()
