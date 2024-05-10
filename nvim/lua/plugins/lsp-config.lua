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
				ensure_installed = {
					"lua_ls",
					"gopls",
					"groovyls",
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			lspconfig.gopls.setup{
				capabilities = capabilities,
				cmd = {"gopls", "serve"},
				filetypes = {"go", "gomod"},
				root_dir = util.root_pattern{"go.work", "go.mod", ".git"},
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			}
			lspconfig.lua_ls.setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			}
			lspconfig.groovyls.setup {
				capabilities = capabilities,
			}

			-- require('lspconfig')['gopls'].setup {}

			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'hover' })
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true , desc = 'go to definition' })
			vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = 'code actions' })
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'rename (refactor)' })
		end
	}
}
