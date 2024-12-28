vim.g.mapleader = " "
vim.opt.showmode = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
--vim.opt.undofile = true

vim.opt.background = "dark"
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 0
--vim.opt.timeoutlen = 60
--
vim.opt.splitright = true
--vim.opt.splitbelow = false
vim.opt.undolevels = 10000

--SIGN COLUMN
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd.highlight("clear SignColumn")
	end,
})
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12

--prime
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = true
--vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.updatetime = 50
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- Set highlight on search, but clear on pressng <Esc> in normal mode
vim.opt.hlsearch = true
