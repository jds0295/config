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
							local value
							if vim.g.copilot_enabled == 1 then
								value = "on"
								return "%#Blue# " .. value
							else
								value = "off"
								return "%#Red# " .. value
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

							if cmp_enabled then
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
		hl_c = vim.api.nvim_get_hl_by_name('lualine_c_normal', true)
		vim.api.nvim_set_hl(0, 'Red', {foreground = 0xFF0000, background = hl_c.background})
		vim.api.nvim_set_hl(0, 'Green', {foreground = 0x00FF00, background = hl_c.background})
		vim.api.nvim_set_hl(0, 'Blue', {foreground = 0x0000FF, background = hl_c.background})
	end
}
