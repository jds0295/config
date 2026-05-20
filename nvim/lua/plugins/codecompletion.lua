return {
	{ --CMP
		"hrsh7th/nvim-cmp", -- Main autocompletion framework
		config = function()
			CMP_ENABLED = false -- for lualine status, toggle and starting state
			require("luasnip.loaders.from_vscode").lazy_load() -- for luasnip to work
			local cmp = require'cmp'
			cmp.setup({
				enabled = CMP_ENABLED, -- can be omitted if wanting enabled by default
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
					{ name = 'nvim_lsp_signature_help', keyword_length = 3},
					{ name = 'path' },
					{ name = 'buffer',keyword_length = 4 },
					-- { name = 'cmdline',keyword_length = 4 },
					{ name = 'tmux',keyword_length = 4 },
					{ name = 'spell',keyword_length = 4 },
					{ name = 'nvim_lua', keyword_length = 4}, -- neovim lua api
				},
				-- formatting
				formatting = {
					fields = {'menu', 'abbr', 'kind'}, -- icon/source, result, type
					format = function(entry, item)
						local menu_icon = {
							luasnip = '󰁨',
							nvim_lsp = 'λ',
							nvim_lsp_signature_help = '',
							path = '',
							buffer = '',
							cmdline = '',
							tmux = '',
							spell = '',
							nvim_lua = '󰢱',
						}
						local kind_icons = {
							Text = "",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰇽",
							Variable = "󰂡",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "󰅲",
						}
						item.menu = menu_icon[entry.source.name]
						item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
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
						select = false,
					}) -- insert the currently selected suggesion (set to false to only insert current explicitly selected item)
				},
			})
			-- Function to toggle code completion
			function _G.toggle_cmp()
				require'cmp'.setup { enabled = not CMP_ENABLED }
				CMP_ENABLED = not CMP_ENABLED
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
	{ "andersevenrud/cmp-tmux" }, --source
	{ "f3fora/cmp-spell" }, -- source
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
			-- Enable/disable copilot by default
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
	},

	-- 99
	-- {
	-- 	"ThePrimeagen/99",
	-- 	config = function()
	-- 		local _99 = require("99")
	--
	-- 		-- For logging that is to a file if you wish to trace through requests
	-- 		-- for reporting bugs, i would not rely on this, but instead the provided
	-- 		-- logging mechanisms within 99.  This is for more debugging purposes
	-- 		local cwd = vim.uv.cwd()
	-- 		local basename = vim.fs.basename(cwd)
	-- 		_99.setup({
	-- 			logger = {
	-- 				level = _99.DEBUG,
	-- 				path = "/tmp/" .. basename .. ".99.debug",
	-- 				print_on_error = true,
	-- 			},
	--
	-- 			--- A new feature that is centered around tags
	-- 			completion = {
	-- 				--- Defaults to .cursor/rules
	-- 				-- I am going to disable these until i understand the
	-- 				-- problem better.  Inside of cursor rules there is also
	-- 				-- application rules, which means i need to apply these
	-- 				-- differently
	-- 				-- cursor_rules = "<custom path to cursor rules>"
	--
	-- 				--- A list of folders where you have your own SKILL.md
	-- 				--- Expected format:
	-- 				--- /path/to/dir/<skill_name>/SKILL.md
	-- 				---
	-- 				--- Example:
	-- 				--- Input Path:
	-- 				--- "scratch/custom_rules/"
	-- 				---
	-- 				--- Output Rules:
	-- 				--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
	-- 				--- ... the other rules in that dir ...
	-- 				---
	-- 				custom_rules = {
	-- 					"scratch/custom_rules/",
	-- 				},
	--
	-- 				--- What autocomplete do you use.  We currently only
	-- 				--- support cmp right now
	-- 				source = "cmp",
	-- 			},
	--
	-- 			--- WARNING: if you change cwd then this is likely broken
	-- 			--- ill likely fix this in a later change
	-- 			---
	-- 			--- md_files is a list of files to look for and auto add based on the location
	-- 			--- of the originating request.  That means if you are at /foo/bar/baz.lua
	-- 			--- the system will automagically look for:
	-- 			--- /foo/bar/AGENT.md
	-- 			--- /foo/AGENT.md
	-- 			--- assuming that /foo is project root (based on cwd)
	-- 			md_files = {
	-- 				"AGENT.md",
	-- 			},
	-- 		})
	--
	-- 		-- Create your own short cuts for the different types of actions
	-- 		vim.keymap.set("n", "<leader>9f", function()
	-- 			_99.fill_in_function()
	-- 		end)
	-- 		-- take extra note that i have visual selection only in v mode
	-- 		-- technically whatever your last visual selection is, will be used
	-- 		-- so i have this set to visual mode so i dont screw up and use an
	-- 		-- old visual selection
	-- 		--
	-- 		-- likely ill add a mode check and assert on required visual mode
	-- 		-- so just prepare for it now
	-- 		vim.keymap.set("v", "<leader>9v", function()
	-- 			_99.visual()
	-- 		end)
	--
	-- 		--- if you have a request you dont want to make any changes, just cancel it
	-- 		vim.keymap.set("v", "<leader>9s", function()
	-- 			_99.stop_all_requests()
	-- 		end)
	--
	-- 		--- Example: Using rules + actions for custom behaviors
	-- 		--- Create a rule file like ~/.rules/debug.md that defines custom behavior.
	-- 		--- For instance, a "debug" rule could automatically add printf statements
	-- 		--- throughout a function to help debug its execution flow.
	-- 		vim.keymap.set("n", "<leader>9fd", function()
	-- 			_99.fill_in_function()
	-- 		end)
	-- 	end,
	-- },
	-- opencode
	-- {
	-- 	"nickjvandyke/opencode.nvim",
	-- 	version = "*", -- Latest stable release
	-- 	dependencies = {
	-- 		{
	-- 			-- `snacks.nvim` integration is recommended, but optional
	-- 			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
	-- 			"folke/snacks.nvim",
	-- 			optional = true,
	-- 			opts = {
	-- 				input = {}, -- Enhances `ask()`
	-- 				picker = { -- Enhances `select()`
	-- 					actions = {
	-- 						opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
	-- 					},
	-- 					win = {
	-- 						input = {
	-- 							keys = {
	-- 								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		---@type opencode.Opts
	-- 		vim.g.opencode_opts = {
	-- 			-- Your configuration, if any; goto definition on the type or field for details
	-- 			server = {
	-- 				port = 4096,
	-- 			},
	-- 		}
	--
	-- 		vim.o.autoread = true -- Required for `opts.events.reload`
	--
	-- 		-- Opencode keymaps under <leader>o
	-- 		require("which-key").add({ { "<leader>o", group = "opencode", icon = "󱚣", } })
	-- 		vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
	-- 		vim.keymap.set({ "n", "x" }, "<leader>oe", function() require("opencode").select() end,                          { desc = "Execute opencode action" })
	-- 		-- vim.keymap.set({ "n", "t" }, "<leader>oo", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
	--
	-- 		vim.keymap.set({ "n", "x" }, "<leader>or",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
	-- 		vim.keymap.set("n",          "<leader>ol",  function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })
	--
	-- 		vim.keymap.set("n", "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
	-- 		vim.keymap.set("n", "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
	-- 	end,
	-- },
	--
	-- agentic
	{
		"carlos-algms/agentic.nvim",
		config = function(_, opts)
			require("which-key").add({ { "<leader>o", group = "agentic", icon = "󱚣" } })
			require("agentic").setup(opts)
		end,
		--- @type agentic.PartialUserConfig
		opts = {
			-- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
			provider = "copilot-acp", -- setting the name here is all you need to get started
		},

		-- these are just suggested keymaps; customize as desired
		keys = {
			{
				"<leader>oo",
				function() require("agentic").toggle() end,
				mode = { "n", "v", "i" },
				desc = "Toggle Agentic Chat"
			},
			{
				"<leader>oe",
				function() require("agentic").new_session() end,
				mode = { "n", "x" },
				desc = "New Agentic Session"
			},
			{
				"<leader>ou",
				function() require("agentic").restore_session() end,
				mode = { "n" },
				desc = "Agentic Restore session",
				silent = true,
			},
			{
				"<leader>os",
				function() require("agentic").stop_generation() end,
				mode = { "n", "x" },
				desc = "Stop Generation",
				silent = true,
			},
			{
				"<leader>ol",
				function() require("agentic").add_selection_or_file_to_context() end,
				mode = { "n" },
				desc = "Add range or file to Agentic context"
			},
			{
				"<leader>or",
				function() require("agentic").add_selection_or_file_to_context() end,
				mode = { "n", "x" },
				desc = "Add range or file to Agentic context"
			},
			{
				"<leader>od",
				function() require("agentic").add_current_line_diagnostics() end,
				desc = "Add current line diagnostic to Agentic",
				mode = { "n" },
			},
			{
				"<leader>oD", -- ai all Diagnostics
				function()
						require("agentic").add_buffer_diagnostics()
				end,
				desc = "Add all buffer diagnostics to Agentic",
				mode = { "n" },
			},
		},
	}

}
