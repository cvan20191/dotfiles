return {
	"mfussenegger/nvim-dap",
	reccomended = true,
	dependencies = {

		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>dde", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
			opts = {
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
			},

			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup({
					icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
					controls = {
						icons = {
							pause = "⏸",
							play = "▶",
							step_into = "⏎",
							step_over = "⏭",
							step_out = "⏮",
							step_back = "b",
							run_last = "▶▶",
							terminate = "⏹",
							disconnect = "⏏",
						},
					},
				})
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end

				--debugging files here
				require("kickstart.plugins.dap.settings.codelldb")
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				opts = {
					ensure_installed = { "cpp" },
					auto_install = true,
					highlight = {
						enable = false,
					},
					indent = { enable = false },
				},
				config = function(_, opts)
					require("nvim-treesitter.install").prefer_git = true
					require("nvim-treesitter.configs").setup(opts)
				end,
			},
			opts = {
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
				all_references = true, -- show virtual text on all all references of the variable (not only definitions)
				clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
				display_callback = function(variable, buf, stackframe, node, options)
					if options.virt_text_pos == "inline" then
						return " = " .. variable.value
					else
						return variable.name .. " = " .. variable.value
					end
				end,
				-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
				virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			},
		},
	},

	keys = {
		{
			"<leader>ddc",
			function()
				--		if vim.fn.filereadable(".vscode/launch.json") then
				--			require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
				--		end
				require("dap").continue()
			end,
			desc = "DAP Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<leader>dds",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
		},
		{
			"<leader>ddt",
			function()
				require("dap").terminate()
			end,
		},
		{
			"<leader>ddl",
			function()
				require("dap").run_last()
			end,
		},
		{
			"<leader>ddr",
			function()
				require("dap").restart()
			end,
		},
		{
			"<leader>ddb",
			function()
				require("dap").clear_breakpoints()
			end,
		},
	},
	config = function()
		-- setup dap config by VsCode launch.json file
		local vscode = require("dap.ext.vscode")
		local json = require("plenary.json")
		vscode.json_decode = function(str)
			return vim.json.decode(json.json_strip_comments(str))
		end
	end,
}
