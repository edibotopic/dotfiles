return {
	{ -- Org mode for Neovim
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/Dropbox/org/**/*",
				org_default_notes_file = "~/Dropbox/org/main.org",
			})
		end,
	},
}
