return {
	'numToStr/Comment.nvim',
	config = function()
		require('Comment').setup({
			toggler = {
				line = 'gcc',
				block = 'gbc',
			},
		})
	end
}
