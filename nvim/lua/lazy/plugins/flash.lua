return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		labels = "asdfghjklqwertyuiopzxcvbnm", -- Custom label configuration
		search = {
			multi_window = true,
			forward = true,
			wrap = true,
			continue = false,
			mode = "exact", -- Search exact matches
			incremental = false,
			exclude = {
				"notify",
				"cmp_menu",
				"noice",
				"flash_prompt",
				function(win)
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
		},
		jump = {
			jumplist = true,
			pos = "start", ---@type "start" | "end" | "range"
			history = false,
			register = false,
			nohlsearch = false,
			autojump = false,
			inclusive = nil,
		},
		label = {
			uppercase = true,
			current = true,
			after = true,
			before = false,
			style = "overlay",
			reuse = "lowercase",
			distance = true,
			min_pattern_length = 0,
			rainbow = {
				enabled = false,
				shade = 5,
			},
		},
		highlight = {
			backdrop = false,
			matches = true,
			priority = 5000,
			groups = {
				match = "FlashMatch",
				current = "FlashCurrent",
				backdrop = "FlashBackdrop",
				label = "FlashLabel",
			},
		},
		modes = {
			char = {
				enabled = true,
				config = function(opts)
					opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")
					opts.jump_labels = opts.jump_labels
						and vim.v.count == 0
						and vim.fn.reg_executing() == ""
						and vim.fn.reg_recording() == ""
				end,
				autohide = false,
				jump_labels = false,
				multi_line = false,
				label = { exclude = "hjkliardc" },

				keys = {
					--"t",
					--					"F",
					--					"t",
					--					"T",
					";",
					",",
				},
				highlight = {
					backdrop = false, -- Disable backdrop highlighting
					matches = false, -- Disable highlighting of matches
				},
			},
		},
		prompt = {
			enabled = true,
			prefix = { { "⚡", "FlashPromptIcon" } },
			win_config = {
				relative = "editor",
				width = 1,
				height = 1,
				row = -1,
				col = 0,
				zindex = 1000,
			},
		},
		remote_op = {
			restore = false,
			motion = false,
		},
	},
	-- Key bindings
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
