return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go", -- golang
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		require("nvim-dap-virtual-text").setup()

		require("dap-go").setup({
			-- Additional dap configurations can be added.
			-- dap_configurations accepts a list of tables where each entry
			-- represents a dap configuration. For more details do:
			-- :help dap-configuration
			dap_configurations = {
				{
					-- Must be "go" or it will be ignored by the plugin
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
			-- delve configurations
			delve = {
				-- the path to the executable dlv which will be used for debugging.
				path = "/Users/390742/.local/share/nvim/mason/packages/delve/dlv",
				-- time to wait for delve to initialize the debug session.
				-- default to 20 seconds
				initialize_timeout_sec = 20,
				-- a string that defines the port to start delve debugger.
				-- default to string "${port}" which instructs nvim-dap
				-- to start the process in a random available port.
				-- if you set a port in your debug configuration, its value will be
				-- assigned dynamically.
				port = "${port}",
				-- additional args to pass to dlv
				args = {},
				-- the build flags that are passed to delve.
				-- defaults to empty string, but can be used to provide flags
				-- such as "-tags=unit" to make sure the test suite is
				-- compiled during debugging, for example.
				-- passing build flags using args is ineffective, as those are
				-- ignored by delve in dap mode.
				-- avaliable ui interactive function to prompt for arguments get_arguments
				build_flags = {},
				-- whether the dlv process to be created detached or not. there is
				-- an issue on Windows where this needs to be set to false
				-- otherwise the dlv server creation will fail.
				-- avaliable ui interactive function to prompt for build flags: get_build_flags
				detached = vim.fn.has("win32") == 0,
				-- the current working directory to run dlv from, if other than
				-- the current working directory.
				cwd = nil,
			},
			-- options related to running closest test
			tests = {
				-- enables verbosity when running the test.
				verbose = false,
			},
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		-- 	dapui.close()
		-- end

		require("which-key").add({
			{
				"<leader>d", group = "debugging",
			}
		})

		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "open UI" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "continue debugging" })
		-- vim.keymap.set("n", "<leader>dl", dap.breakpoints, { desc = "list breakpoints" })
		vim.keymap.set("n", "<F10>", dap.continue, { desc = "continue" })
		vim.keymap.set("n", "<F11>", dap.step_over, { desc = "step over" })
		vim.keymap.set("n", "<F12>", dap.step_into, { desc = "step into" })
	end,
}
