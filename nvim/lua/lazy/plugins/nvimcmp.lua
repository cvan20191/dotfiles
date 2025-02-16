return {
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
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},

		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		--		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})
		local ELLIPSIS_CHAR = "…"
		local MAX_LABEL_WIDTH = 20
		local MIN_LABEL_WIDTH = 20

		cmp.setup({

			formatting = {
				format = function(entry, vim_item)
					-- Remove 'menu' and 'kind' to eliminate extra space
					vim_item.menu = ""
					vim_item.kind = ""

					-- Handle 'abbr' field to fix its width
					local label = vim_item.abbr
					local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
					if truncated_label ~= label then
						vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
					elseif string.len(label) < MIN_LABEL_WIDTH then
						local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
						vim_item.abbr = label .. padding
					end
					return vim_item
				end,
			},

			view = {
				auto_resize = false,
				entries = { name = "custom" }, -- Use custom view for consistent sizing
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					-- Force Copilot to bottom regardless of load time
					function(entry1, entry2)
						if entry1.source.name == "copilot" then
							return false
						end
						if entry2.source.name == "copilot" then
							return true
						end
					end,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
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
				{ name = "nvim_lsp", max_item_count = 5 }, -- Primary language server
				{ name = "copilot", max_item_count = 2 }, -- GitHub Copilot
				{ name = "luasnip", max_item_count = 3 }, -- Snippets
				{ name = "buffer", max_item_count = 5 }, -- Buffer words
				{ name = "lazydev", max_item_count = 2 }, -- Lazy development
			}, {}),
		})
	end,
}
