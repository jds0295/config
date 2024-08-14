return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup {
			}
			local harpoon = require("harpoon")
			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc = 'add to harpoon list'})
			vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = 'open harpoon quick menu'})

			vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc = 'harpoon to item 1'})
			vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc = 'harpoon to item 2'})
			vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc = 'harpoon to item 3'})
			vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc = 'harpoon to item 4'})
			vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {desc = 'harpoon to item 5'})
			vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, {desc = 'harpoon to item 6'})
			vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, {desc = 'harpoon to item 7'})
			vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, {desc = 'harpoon to item 8'})
			vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, {desc = 'harpoon to item 9'})
			vim.keymap.set("n", "<leader>0", function() harpoon:list():select(0) end, {desc = 'harpoon to item 10'})

			-- Toggle previous & next buffers stored within Harpoon list
			-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
			-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
		end
}
