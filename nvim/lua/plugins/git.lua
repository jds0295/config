return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gh', ':Gitsigns toggle_linehl<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gn', ':Gitsigns nav_hunk next preview=true<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gN', ':Gitsigns nav_hunk prev preview=true<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>gg', ':Gitsigns diffthis ~<CR>', { noremap = true, silent = true })
		end
	},
	{
		"tpope/vim-fugitive"
	}
}
