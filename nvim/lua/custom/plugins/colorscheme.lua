return {
	"morhetz/gruvbox",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("gruvbox")

		--require("gruvbox").setup({
		--	commentStyle = { italic = false },
		--	keywordStyle = { italic = false },
		--	overrides = function()
		--		return {
		--			["@variable.builtin"] = { italic = false },
		--		}
		--	end,
		--})
		--	-require("gruvbox").setup({
		--	-	transparent = false,
		--	-	styles = {
		--  -    bold = false;
		--	-		italic = false,
		--	-		sidebars = "transparent",
		--	-		floats = "transparent",
		--	-	},
		--	-})
		--vim.g.gruvbox_contrast_dark = "hard"

		-- vim.cmd.hi 'Comment guifg=#d4d232 gui=none'
		--vim.cmd.hi("WhichKeyFloat ctermbg=BLACK ctermfg=BLACK")
		--	vim.cmd.hi("WhichKey guifg=8fee96")
		--	side columns
		--			vim.cmd("au ColorScheme * hi clear SignColumn")
		--			-- Identifier
		vim.cmd.hi("Identifier guifg=#c0b18b")
		--background
		vim.cmd.hi("Normal guibg=#282828")
		-- Function
		vim.cmd.hi("Function guifg=#7AA2F7")

		-- Statement and Operator
		--		vim.cmd.hi("Statement guifg=#d8d8d8")
		vim.cmd.hi("Operator guifg=#d8d8d8")

		-- Type
		vim.cmd.hi("Type guifg=#8fee96")

		-- StorageClass and Structure
		vim.cmd.hi("StorageClass guifg=#d8d8d8")
		vim.cmd.hi("Structure guifg=#d8d8d8")

		-- Constant, Number, and Boolean
		vim.cmd.hi("Constant guifg=#84edb9")
		vim.cmd.hi("Number guifg=#84edb9")
		vim.cmd.hi("Boolean guifg=#84edb9")

		-- String, Character, and Special
		vim.cmd.hi("String guifg=#22c3a1")
		vim.cmd.hi("Character guifg=#22c3a1")
		vim.cmd.hi("Special guifg=#22c3a1")

		-- SignColumn and LineNr
		--vim.cmd.hi("SignColumn guifg = none")
		vim.cmd.hi("LineNr guifg=#656565")

		vim.cmd.hi("Todo guifg=#d4d232 guibg=NONE gui=bold")

		-- Error
		vim.cmd.hi("Error guifg=#656565 guibg=#d75f5f")

		-- Search
		--vim.cmd.hi("Search gui=bold guifg=#2f2f2f guibg=#d75f5f")

		-- Visual
		--		 vim.cmd.hi 'Visual guifg=#656565 guibg=#585858 gui=NONE'

		-- PreProc and MatchParen
		-- Set matching parenthesis to be neon green
--		vim.cmd.hi("PreProc guifg=#8fee96")
--		vim.cmd.hi("MatchParen guifg=#8fee96")

		-- Tab-bar colors
		--		vim.cmd.hi("TabLine guifg=#656565 guibg=#2f2f2f")
		--		vim.cmd.hi("TabLineSel guifg=#d8d8d8 guibg=#2f2f2f")
		--		vim.cmd.hi("TabLineFill guifg=#2f2f2f guibg=#656565")
		--		vim.cmd.hi("VertSplit guifg=#ffd7af guibg=#ffd7af")
		--		vim.cmd.hi("WinSeparator guifg=#656565")
		--		--vim.cmd("highlight WinSeparator guifg=#ffd7af guibg=#ffd7af")
	end,
}
