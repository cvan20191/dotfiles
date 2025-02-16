return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot-cmp",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- First load copilot
			require("copilot").setup({
				suggestion = { enabled = false }, -- Disable suggestions
				panel = { enabled = false }, -- Disable panel
			})

			-- Then setup copilot-cmp
			require("copilot_cmp").setup({
				async_reg = true,
				delay_ms = 150, -- Delay Copilot suggestions
				fix_pairs = true,
				min_word_length = 2,
			})
		end,
	},
}
