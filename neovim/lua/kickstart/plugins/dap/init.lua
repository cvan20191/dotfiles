return {
	"mfussenegger/nvim-dap",
	lazy = true, -- Lazy load on key mappings

	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", opts = {} }, -- Ensure nvim-treesitter is loaded first
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {}, -- Ensure nvim-dap-virtual-text is loaded after nvim-treesitter
		},
	},

	keys = {
		{
			"<F1>",
			function()
				require("dap").continue()
			end,
			desc = "DAP | Continue",
			silent = true,
		},
		{
			"<F3>",
			function()
				require("dap").step_into()
			end,
			desc = "DAP | Step Into",
			silent = true,
		},
		{
			"<F4>",
			function()
				require("dap").step_over()
			end,
			desc = "DAP | Step Over",
			silent = true,
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "DAP | Step Out",
			silent = true,
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "DAP | Breakpoint",
			silent = true,
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "DAP | Breakpoint Condition",
			silent = true,
		},
	},
	config = function()
		-- Additional configuration for nvim-dap
		require("kickstart.plugins.dap.settings.codelldb")
		--MORE when eneded
		--require("kickstart.plugins.dap.settings.codelldb")
		--require("kickstart.plugins.dap.settings.codelldb")
	end,
}
