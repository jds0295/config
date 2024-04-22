vim.cmd "set tabstop=2" --tab char appears as 2 spaces
vim.cmd "set shiftwidth=2" -- autoindent = 2
vim.cmd "set nu rnu" -- line numbers + relative
vim.cmd "set scrolloff=5"
vim.g.mapleader = " "

vim.opt.termguicolors = true

local map = vim.api.nvim_set_keymap
-- map the hjkl keys + ctrl to move between windows in i, n and t modes
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

map('i', '<C-h>', '<Esc><C-w>h', { noremap = true, silent = true })
map('i', '<C-j>', '<Esc><C-w>j', { noremap = true, silent = true })
map('i', '<C-k>', '<Esc><C-w>k', { noremap = true, silent = true })
map('i', '<C-l>', '<Esc><C-w>l', { noremap = true, silent = true })

map('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })

