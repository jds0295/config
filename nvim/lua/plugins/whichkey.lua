return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

		-- Register key names
		wk.add({
			{ "<C-a>", desc = "Increment number under cursor" },
			{ "<C-x>", desc = "Decrement number under cursor" },
			{ "g<C-a>", desc = "Increment number in visual block mode" },
			{ "g<C-x>", desc = "Decrement number in visual block mode" },
		}, { mode = "n" })  -- Normal mode mappings

		wk.add({
			{ "g<C-a>", desc = "Increment number in visual block mode" },
			{ "g<C-x>", desc = "Decrement number in visual block mode" },
		}, { mode = "v" })  -- Visual mode mappings

		-- Setup which-key
		wk.setup {
		}
	end
}
