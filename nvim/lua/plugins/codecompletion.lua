return {
	{ --CMP
		"hrsh7th/nvim-cmp", -- Main autocompletion framework
		config = function()
			CMP_ENABLED = false -- for lualine status, toggle and starting state
			require("luasnip.loaders.from_vscode").lazy_load() -- for luasnip to work
			local cmp = require'cmp'
			cmp.setup({
				enabled = CMP_ENABLED,
				-- Snippet
				snippet = {
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- vsnip (a)
						require('luasnip').lsp_expand(args.body) -- luasnip (b)
					end
				},
				-- Sources
				sources = {
					-- { name = 'vsnip' }, -- vsnip (a)
					{ name = 'luasnip'}, -- luasnip (b)
					{ name = 'nvim_lsp', keyword_length = 3},
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'path' },
					{ name = 'buffer',keyword_length = 3 },
					{ name = 'cmdline',keyword_length = 3 },
					{ name = 'nvim_lua', keyword_length = 3}, -- neovim lua api
				},
				-- formatting
				formatting = {
					fields = {'menu', 'abbr', 'kind'},
					format = function(entry, item)
						local menu_icon = {
							luasnip = '󰁨',
							nvim_lsp = 'λ',
							nvim_lsp_signature_help = '',
							path = '',
							buffer = '',
							cmdline = '',
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
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-e>'] = cmp.mapping.close(), -- to close the text complete popup
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}) -- insert the currently selected suggesion
				},
			})
			-- Function to enable code completion
			function _G.toggle_cmp()
				if CMP_ENABLED then
					-- If nvim-cmp is enabled, disable it
					require'cmp'.setup { enabled = false }
					CMP_ENABLED = false
				else
					-- If nvim-cmp is disabled, enable it
					require'cmp'.setup { enabled = true }
					CMP_ENABLED = true
				end
			end

			--Bind the function to a key
			vim.api.nvim_set_keymap('n', '<F5>', ':lua toggle_cmp()<CR>', { noremap = true, silent = true })
		end
	},
	-- {	"hrsh7th/vim-vsnip", dependencies = { "cmp-vsnip" } }, -- snippet engine a
	{	"L3MON4D3/LuaSnip", dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" } }, -- snippet engine b
	{	"hrsh7th/cmp-nvim-lsp" }, --source, talks to lsp's loaded on current buffer
	{	"hrsh7th/cmp-nvim-lua" }, --source, for neovim Lua API.
	{	"hrsh7th/cmp-buffer" }, --source
	{	"hrsh7th/cmp-path" }, --source
	{	"hrsh7th/cmp-nvim-lsp-signature-help" }, --source
	{	"hrsh7th/cmp-cmdline", config = function ()
		local cmp = require'cmp'
		-- `/` cmdline setup.
		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})
		-- `:` cmdline setup.
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
					{
						name = 'cmdline',
						option = {
							ignore_cmds = { 'Man', '!' }
						}
					}
				})
		})
	end }, --source

	{ -- copilot
		"github/copilot.vim",
		config = function()
			-- specify node binary path
			vim.g.copilot_node_command = "~/.nvm/versions/node/v20.12.2/bin/node"
			-- disable copilot by default
			vim.g.copilot_enabled = 0
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
	},
	-- Codeium
	{
		"Exafunction/codeium.vim",
		config = function()
			-- disable codeium by default
			vim.g.codeium_enabled = false
			vim.g.codeium_disable_bindings = 1

			-- function to toggle on and off
			vim.api.nvim_create_user_command("CodeiumToggleCustom", function()
				if vim.g.codeium_enabled == true then
					vim.cmd("CodeiumDisable")
					vim.g.codeium_disable_bindings = 1
				else
					vim.cmd("CodeiumEnable")
					vim.g.codeium_disable_bindings = 0
				end
			end, { nargs = 0 })
			-- toggle on and off using F4 key
			vim.keymap.set('n', '<F4>', ':CodeiumToggleCustom<CR>', { noremap = true, silent = true })
			vim.keymap.set('i', '<F4>', '<ESC>:CodeiumToggleCustom<CR>', { noremap = true, silent = true })
		end
	}
}
