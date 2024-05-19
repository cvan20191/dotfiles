return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	["do"] = ":TSUpdate",
	opts = {
		ensure_installed = { "cpp" },
		-- Autoinstall languages that are not installed
		--auto_install = true,
		highlight = {
			enable = true,
		},
	},
}
