return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

		-- Register custom key mappings
		wk.register({
			["<C-a>"] = { "Increment number under cursor" },
			["<C-x>"] = { "Decrement number under cursor" },
			["g<C-a>"] = { "Increment number in visual block mode" },
			["g<C-x>"] = { "Decrement number in visual block mode" },
		}, { mode = "n" })  -- Normal mode mappings

		wk.register({
			["g<C-a>"] = { "Increment number in visual block mode" },
			["g<C-x>"] = { "Decrement number in visual block mode" },
		}, { mode = "v" })  -- Visual mode mappings

		-- Setup which-key
		wk.setup {
		}
	end
}
