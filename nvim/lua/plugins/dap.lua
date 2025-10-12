return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Minimal dependency for dap-ui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup dap-ui
		dapui.setup()

		-- JavaScript/TypeScript/Node.js Configuration
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
		}

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}

		-- JavaScript/TypeScript configurations
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Debug Jest Tests",
				runtimeExecutable = "node",
				runtimeArgs = {
					"./node_modules/jest/bin/jest.js",
					"--runInBand",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
			},
		}

		-- Copy JavaScript config to TypeScript
		dap.configurations.typescript = dap.configurations.javascript

		-- C/C++ Configuration (using codelldb)
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb", -- Assumes codelldb is in PATH
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Launch file with arguments",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " ")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Copy C config to C++
		dap.configurations.cpp = dap.configurations.c

		-- Go Configuration (using delve)
		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv", -- Assumes dlv is in PATH
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug go mod (go run .)",
				request = "launch",
				program = ".",
			},
			{
				type = "delve",
				name = "Debug test",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug test (go mod)",
				request = "launch",
				mode = "test",
				program = ".",
			},
			{
				type = "delve",
				name = "Debug with arguments",
				request = "launch",
				program = "${file}",
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " ")
				end,
			},
			{
				type = "delve",
				name = "Attach to process",
				request = "attach",
				mode = "local",
				processId = require("dap.utils").pick_process,
			},
			{
				type = "delve",
				name = "Debug package",
				request = "launch",
				program = "${workspaceFolder}",
			},
		}

		-- Rust Configuration (using codelldb)
		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Launch file with arguments",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " ")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Launch test",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/deps/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- DAP UI listeners
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

		-- Keybindings
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
		vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last" })
		vim.keymap.set("n", "<Leader>ds", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<Leader>db", dap.step_back, { desc = "Step Back" })
		vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate" })
		
		-- DAP UI toggles
		vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<Leader>de", dapui.eval, { desc = "Evaluate Expression" })

		-- Set breakpoint with condition
		vim.keymap.set("n", "<Leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Set Conditional Breakpoint" })

		-- Visual mode evaluate
		vim.keymap.set("v", "<Leader>de", dapui.eval, { desc = "Evaluate Selection" })

		-- Configure DAP signs using modern method (completely avoid deprecated sign_define)
		-- DAP handles its own signs internally, so we just need to set highlight groups
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
		vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#e51400" })
	end,
}
