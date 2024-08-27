return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest", -- Jest adapter for neotest
		"nvim-neotest/neotest-go",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			discovery = {
				enabled = false,
			},
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "package.json",
					jest_test_discovery = true,
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-go"),
			},
		})

		require("which-key").register({ ["<leader>t"] = { name = "testing" } })

		-- Run the test under the cursor
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tt",
			":lua require('neotest').run.run()<CR>",
			{ noremap = true, silent = true }
		)
		-- Run all tests in the current file
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tf",
			":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ noremap = true, silent = true }
		)

		-- Run the last test
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tl",
			":lua require('neotest').run.run_last()<CR>",
			{ noremap = true, silent = true }
		)

		-- vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end, { noremap = true, silent = true, desc = "run test" })
		-- vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { noremap = true, silent = true, desc = "test file" })
		-- vim.keymap.set("n", "<leader>ta", ":TestSuite -strategy=neovim<CR>", { noremap = true, silent = true })
		-- vim.keymap.set("n", "<leader>tl", ":TestLast -strategy=neovim<CR>", { noremap = true, silent = true })
		-- vim.keymap.set("n", "<leader>tg", ":TestVisit -strategy=neovim<CR>", { noremap = true, silent = true })
	end,
}
