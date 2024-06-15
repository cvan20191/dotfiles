return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- if encountering errors, see telescope-fzf-native readme for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},

	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		require("telescope").setup({
			defaults = {
				preview = {
					treesitter = false,
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fsw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
		--   vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
		vim.keymap.set("n", "<leader>fse", builtin.diagnostics, { desc = "document [e]rrors" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[f]ind recent files ("." for repeat)' })
		vim.keymap.set("n", "<leader>fsn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[f]ind [n]eovim files" })
	end,
}
