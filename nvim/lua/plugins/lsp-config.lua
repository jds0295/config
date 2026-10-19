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
					"eslint", -- js, ts
					"gopls",
					"groovyls",
					"html",
					"jdtls", -- java
					"lua_ls",
					"pyright",
					"ruff", -- python linter
					"rust_analyzer",
					"spectral", -- yaml, json
					"tailwindcss",
					"templ",
					"ts_ls", -- typescript
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
					"debugpy",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local border = {
				{ "╭", "FloatBorder" }, -- tl corner
				{ "─", "FloatBorder" }, -- top
				{ "╮", "FloatBorder" }, -- top right
				{ "│", "FloatBorder" }, -- right vertical
				{ "╯", "FloatBorder" }, -- bottom right
				{ "─", "FloatBorder" }, -- bottom
				{ "╰", "FloatBorder" }, -- bottom left
				{ "│", "FloatBorder" }, -- left vertical
			}

			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			vim.diagnostic.config({
				virtual_text = true, -- shows inline errors/warnings as text (like ghost text next to the line
				underline = true, -- underlines problematic code
				update_in_insert = false, -- don't update diagnostics *while* typing (less noisy, more performant)
				severity_sort = true, -- sort diagnostics by severity, so most important shows first
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					},
				},
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("gopls", {
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod" },
				root_markers = { "go.work", "go.mod", ".git" },
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			vim.lsp.config("templ", {
				filetypes = { "templ" },
			})
			vim.lsp.config("html", {
				filetypes = { "html", "templ" },
			})
			vim.lsp.config("tailwindcss", {
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				init_options = { userLanguages = { templ = "html" } },
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.config("groovyls", {
				filetypes = { "groovy", "Jenkinsfile" },
			})
			vim.lsp.config("spectral", {
				filetypes = { "yaml", "yml" },
			})
			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})
			vim.lsp.config("ccls", {
				filetypes = { "m", "objc" },
				init_options = {
					cache = {
						directory = ".ccls-cache",
					},
				},
			})

			vim.lsp.enable({
				"gopls",
				"templ",
				"rust_analyzer",
				"html",
				"tailwindcss",
				"lua_ls",
				"groovyls",
				"spectral",
				"eslint",
				"ts_ls",
				"svelte",
				"kotlin_language_server",
				"pyright",
				"ruff",
				"ccls",
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "hover" })
			vim.keymap.set(
				"n",
				"<leader>gd",
				vim.lsp.buf.definition,
				{ noremap = true, silent = true, desc = "go to definition" }
			)
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "format document" })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ noremap = true, silent = true, desc = "code actions" }
			)
			vim.keymap.set(
				"n",
				"<leader>rn",
				vim.lsp.buf.rename,
				{ noremap = true, silent = true, desc = "rename (refactor)" }
			)
			-- vim.keymap.set('n', '<leader>gr', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = 'go to references' })
			vim.keymap.set(
				"n",
				"<leader>gr",
				"<cmd>Telescope lsp_references<CR>",
				{ noremap = true, silent = true, desc = "go to references" }
			)
			vim.keymap.set("n", "<leader>gv", function()
				local current = vim.diagnostic.config().virtual_text
				vim.diagnostic.config({ virtual_text = not current })
			end, { noremap = true, silent = true, desc = "Toggle virtual text diagnostics" })
		end,
	},
}
