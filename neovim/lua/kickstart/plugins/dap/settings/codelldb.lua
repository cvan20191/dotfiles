local dap = require("dap")
if not dap.adapters["codelldb"] then
	require("dap").adapters["codelldb"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "codelldb",
			args = {
				"--port",
				"${port}",
			},
		},
	}
end

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {
			"--queue",
			"--output",
			"M",
		},
		stdio = { "spec-M.txt", nil, nil }, -- Redirect stdin from spec-M.txt
		runInTerminal = false,
	},
}
--dap.configurations.c = dap.configurations.cpp
--dap.configurations.rust = dap.configurations.cpp
