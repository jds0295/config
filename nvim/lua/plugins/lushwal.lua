return {
	"oncomouse/lushwal.nvim",
	cmd = { "LushwalCompile" },
	dependencies = {
		{ "rktjmp/lush.nvim" },
		{ "rktjmp/shipwright.nvim" },
	},
	lazy = false,
	config = function ()
		vim.cmd.colorscheme "lushwal"
		vim.g.lushwal_configuration = {
			transparent_background = true,
			addons = {
				lualine = true,
			}
		}
	end
}
