local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}
return {
  "mfussenegger/nvim-dap", -- The DAP
  dependencies = {
    "rcarriga/nvim-dap-ui", -- GUI
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    -- "mxsdev/nvim-dap-vscode-js", -- JavaScript / TypeScript -- Adapter
    "leoluz/nvim-dap-go",      -- golang
  },
  config = function()
    -- local js_debug_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "js-debug-adapter"
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    require("nvim-dap-virtual-text").setup()
    -- require("dap-vscode-js").setup({
    --   -- debugger_path = js_debug_path,
    --   debugger_cmd = { "js-debug-adapter" },
    --   -- debugger_cmd = { js_debug_path },
    -- })


    -- define our own adapter
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "9229",
      executable = {
        command = "js-debug-adapter",
        args = {"9229"},
      }
    }
    -- or use mxsdev/nvim-dap-vscode-js
    -- require("dap-vscode-js").setup({
    --   debugger_cmd = { "js-debug-adapter" },
    --   -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    --   -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    --   -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    -- })

    dap.adapters.debugpy = {
      type = 'executable';
      command = 'python';
      args = { '-m', 'debugpy.adapter',};
    }

    dap.configurations.python = {
      {
        type = 'debugpy'; -- the type here established the link to the adapter definition: `dap.adapters.debugpy`
        request = 'launch';
        name = "Launch file";
      }
    }

    dap.configurations.javascript = {
      -- Debug single nodejs files
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        -- cwd = "${workspaceFolder}",
        sourceMaps = false,
      },
      -- Debug nodejs processes (make sure to add --inspect when you run the process)
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        -- program = "${file}",
        -- adapters = { 'pwa-node', 'node-terminal' }, -- which adapters to register in nvim-dap
        -- address = "127.0.0.1",
        -- port = "9229",
        -- skipFiles = { "<node_internals>/**", "node_modules/**" },
        -- cwd = vim.fn.getcwd() .. "/packages/backend",
        -- cwd = "${workspaceFolder}/packages/backend",
        -- sourceMaps = true,
      },
      -- Divider for the launch.json derived configs
      {
        name = "----- ↓ launch.json configs ↓ -----",
        type = "",
        request = "launch",
      },
      	require("dap.ext.vscode").load_launchjs(nil, nil)
    }

    dap.configurations.typescript = {
      -- Debug single nodejs files
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        -- cwd = "${workspaceFolder}",
        sourceMaps = true,
      },
      -- Debug nodejs processes (make sure to add --inspect when you run the process)
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        -- program = "${file}",
        -- adapters = { 'pwa-node', 'node-terminal' }, -- which adapters to register in nvim-dap
        -- address = "127.0.0.1",
        -- port = "9229",
        -- skipFiles = { "<node_internals>/**", "node_modules/**" },
        -- cwd = vim.fn.getcwd() .. "/packages/backend",
        -- cwd = "${workspaceFolder}/packages/backend",
        -- sourceMaps = true,
      },
      -- Divider for the launch.json derived configs
      {
        name = "----- ↓ launch.json configs ↓ -----",
        type = "",
        request = "launch",
      },
      	require("dap.ext.vscode").load_launchjs(nil, nil)
    }

    -- go debugging
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
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define('DapBreakpoint', {text='', texthl='DiagnosticError', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='', texthl='DiagnosticInfo', linehl='Visual', numhl=''})
    vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DiagnosticWarn', linehl='', numhl=''})

    require("which-key").add({ { "<leader>d", group = "debugging" } })

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "open UI" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "continue debugging" })
    vim.keymap.set("n", "<leader>ds", dap.close, { desc = "stop debugging" })
    vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "disconnect" })
    vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "run to cursor" })
    vim.keymap.set("n", "<leader>dl", function() dap.list_breakpoints() vim.cmd("copen") end, { desc = "list breakpoints" })
    -- vim.keymap.set("n", "<leader>dl", function() dap.list_breakpoints() end, { desc = "list breakpoints" })
    -- vim.keymap.set("n", "<leader>dl", dap.list_breakpoints, { desc = "list breakpoints" })
    vim.keymap.set("n", "<F9>", dap.continue, { desc = "continue" })
    vim.keymap.set("n", "<F10>", dap.step_into, { desc = "step into" })
    vim.keymap.set("n", "<F11>", dap.step_over, { desc = "step over" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "step out" })
  end,
}
