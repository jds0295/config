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
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true, desc = 'git status' })
			vim.keymap.set('n', '<leader>g3', ':Gvdiffsplit!<CR>', { noremap = true, silent = true, desc = 'git diff 3 split' })
			vim.keymap.set('n', '<leader>gt', ':diffget //2<CR>', { noremap = true, silent = true, desc = 'git accept left' })
			vim.keymap.set('n', '<leader>gy', ':diffget //3<CR>', { noremap = true, silent = true, desc = 'git accept right' })
		end
	}
}
