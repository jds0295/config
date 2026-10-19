return {
	'christoomey/vim-tmux-navigator',
	lazy = false,
	init = function()
		-- disable the plugin's default mappings (they use the Vim-style
		-- `<C-w>:` prefix in terminal mode, which leaks command text into
		-- the shell in Neovim). We define our own below.
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- normal mode: seamless nvim window <-> tmux pane navigation
		map('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', opts)
		map('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', opts)
		map('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', opts)
		map('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', opts)

		-- terminal mode: leave terminal mode first, then navigate
		map('t', '<C-h>', [[<C-\><C-n><cmd>TmuxNavigateLeft<CR>]], opts)
		map('t', '<C-j>', [[<C-\><C-n><cmd>TmuxNavigateDown<CR>]], opts)
		map('t', '<C-k>', [[<C-\><C-n><cmd>TmuxNavigateUp<CR>]], opts)
		map('t', '<C-l>', [[<C-\><C-n><cmd>TmuxNavigateRight<CR>]], opts)
	end,
}
