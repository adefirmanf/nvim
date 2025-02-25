return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Ensure to install `codelldb`
		local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		-- Go adapters `delve`
		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		-- GO
		dap.configurations.go = {
			{
				name = "Launch",
				type = "delve",
				request = "launch",
				program = "${file}",
			},
			{
				name = "Debug test", -- configuration for debugging test files
				type = "delve",
				request = "launch",
				mode = "test",
				program = "${file}",
			}
		}

		-- RUST
		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					local cwd = vim.fn.getcwd()
					local debug_path = cwd .. "/target/debug/"
					-- Get the Cargo project name from `Cargo.toml`
					local cargo_toml = io.open(cwd .. "/Cargo.toml", "r")
					if cargo_toml then
						for line in cargo_toml:lines() do
							local name = line:match('^name%s*=%s*"(.*)"')
							if name then
								cargo_toml:close()
								return debug_path .. name
							end
						end
						cargo_toml:close()
					end
					-- If Cargo.toml parsing fails, ask the user
					return vim.fn.input("Path to executable: ", debug_path, "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Optionally set up dap-ui
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
