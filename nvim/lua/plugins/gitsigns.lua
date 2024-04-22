return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
		vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<leader>gh', ':Gitsigns toggle_linehl<CR>', { noremap = true, silent = true })
	end
}
