return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.npm_groovy_lint,
				null_ls.builtins.formatting.prettierd,
				-- null_ls.builtins.diagnostics.eslint_d,
				--require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
			},
		})
		vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {desc = 'null-ls format document'})
	end
}
