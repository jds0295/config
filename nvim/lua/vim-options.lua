vim.cmd "set tabstop=2" --tab char appears as 2 spaces
vim.cmd "set shiftwidth=2" -- autoindent = 2
vim.cmd "set nu rnu" -- line numbers + relative
vim.cmd "set scrolloff=5" -- always see x lines above or below cursor
vim.cmd "set nowrap" -- no text wrapping
vim.cmd "set clipboard=unnamedplus" -- system clipboard is synced with standard yank / paster operations
vim.cmd "set noswapfile"
vim.opt.spell = true
vim.opt.spelllang = { 'en_gb' }
vim.g.mapleader = " " -- leader key

vim.opt.termguicolors = true

local map = vim.api.nvim_set_keymap

-- "This unsets the "last search pattern" register by hitting return
vim.keymap.set('n', '<CR>', ':noh<CR><CR>', { noremap = true, silent = true })

-- window navigation (n/i/t) is handled by vim-tmux-navigator (see plugins/tmux.lua)
-- so nvim windows and tmux panes are navigated seamlessly with <C-h/j/k/l>.
-- that plugin does not handle `i` mode, so mapping here still, though it does not really work as intended.
map('i', '<C-h>', '<Esc><C-w>h', { noremap = true, silent = true })
map('i', '<C-j>', '<Esc><C-w>j', { noremap = true, silent = true })
map('i', '<C-k>', '<Esc><C-w>k', { noremap = true, silent = true })
map('i', '<C-l>', '<Esc><C-w>l', { noremap = true, silent = true })

-- esc gets out of terminal mode
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- alt + c in visual mode to copy to system clipboard
-- map('v', '<M-c>', '"+y', { noremap = true, silent = true })

-- "Pick up" other files
vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
    ["Jenkinsfile.*"] = "groovy"
  }
})

-- treat Jenkinsfiles as groovy
-- vim.api.nvim_command('autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy')

-- auto-reload files changed on disk (e.g. by external agents or tools)
-- vim.opt.autoread = true
-- vim.opt.updatetime = 1000
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
--   command = "checktime"
-- })
