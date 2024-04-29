return {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		require("lualine").setup {
			options = {
				theme = 'dracula',
				globalstatus = true,
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {
					-- copilot
					{
						function()
							local status
							if vim.g.copilot_enabled == 1 then
								status = vim.fn.execute("Copilot status"):match('Copilot: (%w+)')
								return "%#Blue# " .. status
							else
								status = "off"
								return "%#Red# " .. status
							end
						end
					},
					-- codeium
					{
						'vim.fn["codeium#GetStatusString"]()',
						fmt = function(str)
							return "{…} " .. str:lower():match("^%s*(.-)%s*$")
						end
					},
					-- cmp
					{
						function()
							if CMP_ENABLED then
								return "⎁ " .. "%#Green#%#lualine_c_normal#"
							else
								return "⎁ " .. "%#Red#%#lualine_c_normal#"
							end
						end
					}
				},
				lualine_y = {
					'encoding',
					{'fileformat',
						symbols = {
							unix = '', -- e712
							dos = '',  -- e70f
							mac = '',  -- e711
					}},
					'filetype',
				},
				lualine_z = {
					'progress',
					'location',
				}
			}
		}
		local hl_c = vim.api.nvim_get_hl_by_name('lualine_c_normal', true)
		local hl_error = vim.api.nvim_get_hl_by_name('Error', true)
		local hl_boolean = vim.api.nvim_get_hl_by_name('Boolean', true)
		local hl_character = vim.api.nvim_get_hl_by_name('Character', true)
		vim.api.nvim_set_hl(0, 'Red', {foreground = hl_error.foreground, background = hl_c.background})
		vim.api.nvim_set_hl(0, 'Green', {foreground = hl_character.foreground, background = hl_c.background})
		vim.api.nvim_set_hl(0, 'Blue', {foreground = hl_boolean.foreground, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Red', {foreground = 0xFF0000, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Green', {foreground = 0x00FF00, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Blue', {foreground = 0x0000FF, background = hl_c.background})
	end
}
