vim.cmd "set tabstop=2" --tab char appears as 2 spaces
vim.cmd "set shiftwidth=2" -- autoindent = 2
vim.g.mapleader = " "

-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	--colour themes
	{ "Mofiqul/dracula.nvim", name = "dracula", priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- fzf and grep
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- highlighting etc
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	}, 
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	}
}

local opts = {
}

require("lazy").setup(plugins, opts)

-- ##############
-- Keys
-- ##############
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left <CR>', {})

-- vim.cmd.colorscheme "dracula"
vim.cmd.colorscheme "catppuccin"

