local function picker(lhs, name, desc)
	return {
		lhs,
		function()
			require("telescope.builtin")[name]()
		end,
		desc = desc,
	}
end

return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		keys = {
			picker("<leader>sh", "help_tags", "[S]earch [H]elp"),
			picker("<leader>sk", "keymaps", "[S]earch [K]eymaps"),
			picker("<leader>sf", "find_files", "[S]earch [F]iles"),
			picker("<leader>ss", "builtin", "[S]earch [S]elect Telescope"),
			picker("<leader>sw", "grep_string", "[S]earch current [W]ord"),
			picker("<leader>sg", "live_grep", "[S]earch by [G]rep"),
			picker("<leader>sd", "diagnostics", "[S]earch [D]iagnostics"),
			picker("<leader>sr", "resume", "[S]earch [R]esume"),
			picker("<leader>s.", "oldfiles", '[S]earch Recent Files ("." for repeat)'),
			picker("<leader><leader>", "buffers", "[ ] Find existing buffers"),
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{
				"<leader>s/",
				function()
					require("telescope.builtin").live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end,
				desc = "[S]earch [/] in Open Files",
			},
			{
				"<leader>sn",
				function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), hidden = true })
				end,
				desc = "[S]earch [N]eovim files",
			},
			{
				"<leader>so",
				function()
					require("telescope.builtin").find_files({ cwd = "~/Dropbox/org" })
				end,
				desc = "[S]earch [O]rg files",
			},
			{
				"<leader>sp",
				function()
					local builtin = require("telescope.builtin")
					local root = vim.fs.root(0, ".git")
					if root then
						builtin.git_files({ cwd = root })
					else
						builtin.find_files()
					end
				end,
				desc = "[S]earch [P]roject repo",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				defaults = {
					mappings = {
						n = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
						i = {
							["<c-h>"] = "which_key",
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
}
