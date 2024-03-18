-- plugins.lua
local M = {}

function M.setup()
	-- Plugin setup

	local lspconfig = require("lspconfig")


	local handlers = {
		["textDocument/completion"] = vim.lsp.with(vim.lsp.handlers.completion, { border = "rounded" }),
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}
	lspconfig.gopls.setup({
		handlers = handlers,
		settings = {
			Lua = {
				hints = { enable = true },
			},
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})

	lspconfig.lua_ls.setup {
		handlers = handlers,
		on_init = function(client)
			--local path = client.workspace_folders[1].name
			--if not vim.uv.fs_stat(path .. '/.luarc.json') then
			-- Make the server aware of Neovim runtime files
			--client.config.settings.Lua.workspace.library = { vim.env.VIMRUNTIME }
			-- or for everything:
			client.config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("", true)
			client.notify("workspace/didChangeConfiguration", {
				settings = client.config.settings
			})
			--end
		end
	}

	lspconfig.rust_analyzer.setup {}
end

return M
