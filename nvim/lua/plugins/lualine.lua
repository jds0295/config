return {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		require("lualine").setup {
			options = {
				theme = 'dracula',
				-- theme = 'ayu_mirage',
				-- theme = 'iceberg_dark',
				-- theme = 'pywal',
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
								return " " .. status
							else
								status = "off"
								return " " .. status
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
								return "⎁ " .. ""
							else
								return "⎁ " .. ""
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
		-- local hl_red = vim.api.nvim_get_hl_by_name('RainbowDelimiterRed', true)
		-- local hl_green = vim.api.nvim_get_hl_by_name('RainbowDelimiterGreen', true)
		-- local hl_blue = vim.api.nvim_get_hl_by_name('RainbowDelimiterBlue', true)
		-- vim.api.nvim_set_hl(0, 'Red', {foreground = hl_red.foreground, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Green', {foreground = hl_green.foreground, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Blue', {foreground = hl_blue.foreground, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Red', {foreground = 0xFF0000, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Green', {foreground = 0x00FF00, background = hl_c.background})
		-- vim.api.nvim_set_hl(0, 'Blue', {foreground = 0x0000FF, background = hl_c.background})
	end
}
