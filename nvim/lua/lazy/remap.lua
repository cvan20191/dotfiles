vim.g.clever_f_not_overwrites_standard_mappings = 1
vim.g.clever_f_mark_char_color = "CleverFHighlight"
vim.keymap.set({ "n", "x", "o" }, "f", function()
	require("eyeliner").highlight({ forward = true })
	return "<Plug>(clever-f-f)"
end, { expr = true })

vim.keymap.set({ "n", "x", "o" }, "F", function()
	require("eyeliner").highlight({ forward = true })
	return "<Plug>(clever-f-F)"
end, { expr = true })

---------
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<leader>dp", vim.cmd.Ex)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "swap selected text" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
--remap control _ because mech keyboard
--
vim.keymap.set("n", "N", "Nzzzv")
vim.opt.hlsearch = true
vim.api.nvim_set_hl(0, "@function.call", { fg = "#b8bb26", bold = true }) -- Example Gruvbox color
vim.diagnostic.config({ virtual_text = false })
--vim.keymap.set("n", "<leader>e", ":Ex" )
vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config({
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	})
end, { desc = "toggle diagnostic" })

vim.api.nvim_create_user_command("Cwd", function()
	vim.cmd("cd %:p:h")
	print("Changed directory to: " .. vim.fn.getcwd())
end, {})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--vim.keymap.set("t", "F", "<C-\\><C-n><C-f>", { desc = "vim from terminal mode" })
--vim.keymap.set("n", "<leader>fbc", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })
--vim.api.nvim_set_keymap("n", "<leader>fwd", ":cd %:p:h<CR>", { noremap = true, silent = true })
-- highlight when yanking (copying) text
--
-- //opens new tmux session
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.api.nvim_create_user_command("Ts", function()
	local current_dir = vim.fn.getcwd()
	vim.cmd("silent !tmux-sessionizer " .. current_dir)
end, {})
-- deletes word without puttingit in register
vim.keymap.set("n", "<leader>pe", "<cmd>Ex<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.api.nvim_create_autocmd("textyankpost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
