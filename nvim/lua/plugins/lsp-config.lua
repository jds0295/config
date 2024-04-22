return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" }
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup{
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			}
			-- lspconfig.gopls.setup{}
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true })
		end
	}
}
