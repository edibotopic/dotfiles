return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- this plugin does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			local ensure_installed = {
				"bash",
				"c",
				-- "diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"clojure",
				"dart",
				"go",
				-- "query",
				-- "vim",
				-- "vimdoc",
			}

			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local ft = args.match
					local lang = vim.treesitter.language.get_lang(ft) or ft
					if not vim.tbl_contains(ensure_installed, lang) then
						return
					end

					local loaded, err = vim.treesitter.language.add(lang)
					if not loaded then
						if not err:match("^No parser for language") then
							vim.notify(err, vim.log.levels.ERROR)
						end
						return
					end

					vim.treesitter.start(args.buf)
					vim.bo[args.buf].syntax = ""
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldlevel = 99
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
