--if vim.g.vscode then
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
				--			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	--{ "Bilal2453/luvit-meta", lazy = true },
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			--{ "folke/neodev.nvim", opts = {} },
		},

		config = function()
			--	vim.api.nvim_create_autocmd("LspAttach", {
			--		group = vim.api.nvim_create_augroup("DisableSemanticTokens", { clear = true }),
			--		callback = function(args)
			--			local client = vim.lsp.get_client_by_id(args.data.client_id)
			--			if client then
			--				client.server_capabilities.semanticTokensProvider = nil
			--			end
			--		end,
			--	})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("n", "<leader>fs", require("telescope.builtin").lsp_workspace_symbols, "[D]ocument [S]ymbols")
					map("n", "<leader>cr", vim.lsp.buf.rename, "LSP:[C]ode [R]ename")
					map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
					--map("i", "<C-j>", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				html = {},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"html-lsp",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					--		 `friendly-snippets` contains a variety of premade snippets.
					--		    See the README about individual language/framework/plugin snippets:
					--		    https://github.com/rafamadriz/friendly-snippets
					--					{
					--						"rafamadriz/friendly-snippets",
					--						config = function()
					--							require("luasnip.loaders.from_vscode").lazy_load()
					--						end,
					--},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				performance = {
					max_view_entries = 10,
					async_budget = 5,
					debounce = 0,
					throttle = 0,
					fetching_timeout = 0,
					confirm_resolve_timeout = 5,
				},

				view = {
					docs = {
						auto_open = false,
					},
				},

				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),

					["<C-k>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
					},
					{ name = "lazydev", groupIndex = 0 },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{ import = "lazy.plugins" },
	{},
})
--end
