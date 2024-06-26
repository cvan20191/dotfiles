return {

	{
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
			vim.keymap.del({ "x", "o" }, "X")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
}
