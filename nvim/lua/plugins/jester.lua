return {
	"David-Kunz/jester",
	config = function()
		local jester = require("jester")

		jester.setup({
			cmd = " npm test -- $file",
			terminal_cmd = ":split | terminal",
			dap = {
				type = "pwa-node",
			}
		})

		require("which-key").add({ { "<leader>j", group = "jest testing", icon = "󰤑", } })

		vim.keymap.set('n', '<leader>jt', jester.run, { desc = 'run nearest'})
		vim.keymap.set('n', '<leader>jf', jester.run_file, { desc = 'run file'})
		vim.keymap.set('n', '<leader>jl', jester.run_last, { desc = 'run last'})
		vim.keymap.set('n', '<leader>jd', jester.debug, { desc = 'debug nearest test'})
	end
}
