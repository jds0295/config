return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			require("which-key").add({ { "<leader>f", group = "telescope", icon = "󰭎", } })
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files'})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep all files'})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'open buffer names'})
			vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'fzf current buffer'})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'fzf help'})
		end
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		config = function()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {
							-- even more opts
						}
					}
				},
				defaults = {
					path_display = { "truncate" },
				}
			}
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end
	}
}
