return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"templ",
					"rust_analyzer",
					"html",
					"tailwindcss",
					"groovyls",
					"spectral", -- yaml, json
					"eslint", -- js, ts
					"ts_ls", -- typescript
					"jdtls", -- java
				},
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"js-debug-adapter",
					"delve",
				},
			})
		end,
	},
	-- {
	-- 	"rshkarin/mason-nvim-lint",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-lint",
	-- 	},
	-- 	config = function()
	-- 		require("mason-nvim-lint").setup({
	-- 			ensure_installed = {
	-- 				"npm-groovy-lint",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"npm-groovy-lint",
					"prettierd",
					"jq",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod" },
				root_dir = util.root_pattern({ "go.work", "go.mod", ".git" }),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			lspconfig.templ.setup({
				capabilities = capabilities,
				filetypes = { "templ" },
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "templ" },
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				init_options = { userLanguages = { templ = "html" } },
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.groovyls.setup({
				capabilities = capabilities,
				filetypes = { "groovy", "Jenkinsfile" },
			})
			lspconfig.spectral.setup({
				capabilities = capabilities,
				filetypes = { "yaml", "yml" },
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.kotlin_language_server.setup({
				capabilities = capabilities,
			})
			-- require('lspconfig')['gopls'].setup {}

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "hover" })
			vim.keymap.set( "n", "<leader>gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "go to definition" })
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format document" })
			vim.keymap.set( { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "code actions" })
			vim.keymap.set( "n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "rename (refactor)" })
			-- vim.keymap.set('n', '<leader>gr', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = 'go to references' })
			vim.keymap.set( "n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true, desc = "go to references" })
		end,
	},
}
