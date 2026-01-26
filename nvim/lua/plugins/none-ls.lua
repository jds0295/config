return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.npm_groovy_lint,
				null_ls.builtins.formatting.prettierd,
				-- null_ls.builtins.diagnostics.mypy,
				require("none-ls.formatting.jq"), -- requires none-ls-extras.nvim
				-- require("none-ls.diagnostics.eslint"),
				-- null_ls.builtins.diagnostics.clang_check.with({
				-- 	command = "monkeyc",
				-- 	args = { "-z", "-f", "$FILENAME" },
				-- }),
			},
		})
	end,
}
