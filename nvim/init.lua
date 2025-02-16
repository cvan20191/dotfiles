--	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--	if not vim.loop.fs_stat(lazypath) then
--		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--		vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--	end ---@diagnostic disable-next-line: undefined-field
--	vim.opt.rtp:prepend(lazypath)
--
--	require("lazy").setup({
--
--		"folke/flash.nvim",
--		event = "VeryLazy",
--
--		---@type Flash.Config
--		opts = {},
---- stylua: ignore
----
--keys = {
--  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
--  { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
--  { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
--  { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--  { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--},
--	})
--else
--
--vscode
vim.g.mapleader = " "
-- Conditional mappings for VS Code
if vim.g.vscode then
	-- Toggle terminal in normal mode
	vim.keymap.set("n", "<leader>t", function()
		vim.fn.VSCodeNotify("workbench.action.terminal.toggleTerminal")
	end, { noremap = true })

	-- Toggle terminal in terminal mode
	vim.keymap.set("t", "<leader>t", function()
		vim.fn.VSCodeNotify("workbench.action.terminal.toggleTerminal")
	end, { noremap = true })

	-- Other VS Code-specific settings or mappings...
	print("Running inside VS Code with Neovim extension!")
else
	print("Running in standalone Neovim")
end
--vscode
require("lazy.options")
require("lazy.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{

		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Lazydev: sets up Lua LSP for your Neovim config, runtime, and plugins
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the "vim.uv" word is seen
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Auto-attach LSP keymaps whenever an LSP client attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set(
						"n",
						"gd",
						require("telescope.builtin").lsp_definitions,
						vim.tbl_extend("force", { desc = "[G]oto [D]efinition" }, opts)
					)
					vim.keymap.set(
						"n",
						"gr",
						require("telescope.builtin").lsp_references,
						vim.tbl_extend("force", { desc = "[G]oto [R]eferences" }, opts)
					)
					vim.keymap.set(
						"n",
						"<leader>fs",
						require("telescope.builtin").lsp_workspace_symbols,
						vim.tbl_extend("force", { desc = "[D]ocument [S]ymbols" }, opts)
					)
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						vim.tbl_extend("force", { desc = "LSP:[C]ode [R]ename" }, opts)
					)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", { desc = "[C]ode [A]ction" }, opts)
					)
					vim.keymap.set(
						"n",
						"K",
						vim.lsp.buf.hover,
						vim.tbl_extend("force", { desc = "Hover Documentation" }, opts)
					)
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ import = "lazy.plugins" },
	{},
})
