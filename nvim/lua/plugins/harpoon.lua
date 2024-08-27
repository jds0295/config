return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
	require("harpoon").setup {
	}
	local harpoon = require("harpoon")
	local wk = require("which-key")

	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc = 'add to harpoon list'})
	vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = 'open harpoon quick menu'})

	for i = 0, 9 do
	    vim.keymap.set("n", "<leader>" ..(i % 10), function() harpoon:list():select(i) end, {desc = 'harpoon to item ' .. i})
	    wk.add({"<leader>" .. i, hidden = true})
	end

	-- Toggle previous & next buffers stored within Harpoon list
	-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
	-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
}
