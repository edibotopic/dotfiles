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

	{ -- Pretty unicode bullets instead of raw asterisks
		"nvim-orgmode/org-bullets.nvim",
		ft = { "org" },
		opts = {},
	},

	{ -- Telescope pickers for org headlines, tags, refile and link insertion
		"nvim-orgmode/telescope-orgmode.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-orgmode/orgmode",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("orgmode")

			local ext = require("telescope").extensions.orgmode
			vim.keymap.set("n", "<leader>oh", ext.search_headings, { desc = "[O]rg [H]eadlines" })
			vim.keymap.set("n", "<leader>ot", ext.search_tags, { desc = "[O]rg [T]ags" })
			vim.keymap.set("n", "<leader>or", ext.refile_heading, { desc = "[O]rg [R]efile" })
			vim.keymap.set("n", "<leader>ol", ext.insert_link, { desc = "[O]rg Insert [L]ink" })
		end,
	},
}
