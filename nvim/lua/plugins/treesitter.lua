return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	-- config = function()
	-- 	local config = require("nvim-treesitter.configs")
	-- 	config.setup({
	-- 		ensure_installed = {"lua", "go"},
	-- 		auto_install = true,
	-- 		highlight = { enable = true },
	-- 		indent = { enable = true }
	-- 	})
	-- end
}
