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

	{ -- Render markdown with the plugin's default styling, plus org headlines/
		-- bullets/code-blocks/quotes via a custom treesitter handler, since
		-- render-markdown.nvim ships no built-in org support. Handler adapted
		-- from: https://github.com/MeanderingProgrammer/render-markdown.nvim/discussions/359
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "org" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			file_types = { "markdown", "org" },
			custom_handlers = {
				org = {
					parse = function(ctx)
						local query = vim.treesitter.query.parse("org", [[
							(headline (stars) @headline)
							((expr) @dash (#match? @dash "^-----+$"))
							(block name: (expr) @_name (#match? @_name "(SRC|src)")) @codeblock
							(paragraph . (expr) @quote (#eq? @quote ">"))
						]])

						local bullets = { "◉", "○", "✸", "✿" }
						local width = vim.api.nvim_win_get_width(0)
						local marks = {}

						for id, node in query:iter_captures(ctx.root, ctx.buf) do
							local capture = query.captures[id]
							local start_row, start_col, end_row = node:range()

							if capture == "headline" then
								local level = #vim.trim(vim.treesitter.get_node_text(node, ctx.buf))
								local bullet = bullets[((level - 1) % #bullets) + 1]
								table.insert(marks, {
									start_row = start_row,
									start_col = 0,
									opts = {
										end_col = 0,
										end_row = start_row + 1,
										hl_group = "Headline",
										hl_eol = true,
										virt_text = { { string.rep(" ", level - vim.fn.strwidth(bullet)) .. bullet, "Headline" } },
										virt_text_pos = "overlay",
									},
								})
							elseif capture == "dash" then
								table.insert(marks, {
									start_row = start_row,
									start_col = 0,
									opts = {
										virt_text = { { ("-"):rep(width), "Dash" } },
										virt_text_pos = "overlay",
										hl_mode = "combine",
									},
								})
							elseif capture == "codeblock" then
								table.insert(marks, {
									start_row = start_row,
									start_col = 0,
									opts = { end_col = 0, end_row = end_row, hl_group = "CodeBlock", hl_eol = true },
								})
							elseif capture == "quote" then
								table.insert(marks, {
									start_row = start_row,
									start_col = start_col,
									opts = {
										virt_text = { { "┃", "Quote" } },
										virt_text_pos = "overlay",
										hl_mode = "combine",
									},
								})
							end
						end

						return marks
					end,
				},
			},
		},
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
