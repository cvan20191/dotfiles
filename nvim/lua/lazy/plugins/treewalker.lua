return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- Whether to briefly highlight the node after jumping to it
		highlight_duration = 250, -- How long should above highlight last (in ms)
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<C-n>", ":Treewalker Down<CR>zzzv", { noremap = true })
		vim.api.nvim_set_keymap("n", "<C-p>", ":Treewalker Up<CR>zzzv", { noremap = true })
		vim.api.nvim_set_keymap("n", "<C-k>", ":Treewalker Left<CR>zzzv", { noremap = true })
		vim.api.nvim_set_keymap("n", "<C-j>", ":Treewalker Right<CR>zzzv", { noremap = true })
	end,
}
