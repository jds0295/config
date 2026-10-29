return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                                                                 ]],
			[[                                                                 ]],
			[[                                                                 ]],
			[[                                                                 ]],
			[[                                                               ]],
			[[    █████████████        █████      ██                     ]],
			[[   ██████████    ███  █████                             ]],
			[[          ████    █████████████ ███   ███████████   ]],
			[[         ███████████ ██  ████████ █████ ██████████████   ]],
			[[  ██  ██████ ██ ████████████ █████ █████ ████ █████   ]],
			[[ ███  ██████ ██ █    ███████ █████ █████ ████ █████  ]],
			[[ ██████████ ███████ ███████ ████ █████ █████ ████ ██████ ]],
			[[                                                                 ]],
			[[                                                                 ]],
			[[                                                                 ]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", "<cmd>ene <CR>"),
			dashboard.button("SPC f f", "󰈞  Find file"),
			dashboard.button("SPC f g", "󰈬  Find word"),
			dashboard.button("f h", "󰊄  Help tags", "<cmd>Telescope help_tags<CR>"),
			dashboard.button("g s", "  Git status", "<cmd>Git<CR>"),
			dashboard.button("c", "  Config", "<cmd>e $MYVIMRC | cd %:p:h<CR>"),
			dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
		dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
			-- dashboard.button("SPC f h", "󰊄  Recently opened files"),
			-- dashboard.button("SPC f r", "  Frecency/MRU"),
			-- dashboard.button("SPC f m", "  Jump to bookmarks"),
			-- dashboard.button("SPC s l", "  Open last session"),
		    }
		alpha.setup(dashboard.opts)
	end,
}
