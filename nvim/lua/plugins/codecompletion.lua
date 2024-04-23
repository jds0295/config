return {
	{ --CMP
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require'cmp'
			-- cmp_endabled = flase
			cmp.setup({
				-- Snippet
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end
				},
				-- Sources
				sources = {
					{ name = 'nvim_lsp', keyword_length = 3},
					{ name = 'vsnip', keyword_length = 2},
					{ name = 'path' },
					{ name = 'buffer',keyword_length = 2 },
					{ name = 'cmdline' },
					{ name = 'nvim_lua', keyword_length = 2},
					-- { name = 'nvim_lsp_signature_help' },
				},
				-- formatting
				formatting = {
					fields = {'menu', 'abbr', 'kind'},
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = 'λ',
							vsnip = '󰁨',
							buffer = '',
							path = '',
							cmdline = '',
							nvim_lua = '󰢱',
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
				-- Window styling
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- Mappings 
				mapping = {
					['<M-Space>'] = cmp.mapping.complete(), -- to bring up the code completion at current cursor
					['<Tab>'] = cmp.mapping.select_next_item(), -- Move to next entry in the list
					['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Move to previous entry in the list
					['<C-e>'] = cmp.mapping.close(), -- to close the text complete popup
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}) -- insert the currently selected suggesion
				},
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/cmp-nvim-lsp"
	},
	{
		"hrsh7th/cmp-nvim-lua"
	},
	{
		"hrsh7th/cmp-buffer"
	},
	{
		"hrsh7th/cmp-path"
	},
	{
		"hrsh7th/cmp-cmdline"
	},
	{
		"hrsh7th/cmp-vsnip"
	},
	{
		"hrsh7th/vim-vsnip"
	},
	{ -- copilot
		"github/copilot.vim",
		config = function()
			-- specify node binary path
			vim.g.copilot_node_command = "~/.nvm/versions/node/v20.12.2/bin/node"
			-- enable copilot by default
			vim.g.copilot_enabled = 1

			-- function to toggle on and off
			vim.api.nvim_create_user_command("CopilotToggle", function()
				if vim.g.copilot_enabled == 1 then
					vim.cmd("Copilot disable")
				else
					vim.cmd("Copilot enable")
				end
			end, { nargs = 0 })


			-- toggle on and off using F3 key
			vim.keymap.set('n', '<F3>', ':CopilotToggle<CR>', { noremap = true, silent = true })
			vim.keymap.set('i', '<F3>', '<ESC>:CopilotToggle<CR>', { noremap = true, silent = true })
		end
	}
}
