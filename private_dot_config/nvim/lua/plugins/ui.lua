return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.o.timeoutlen
			delay = 0,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			-- Document existing key chains
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		-- you can set set configuration options here
		-- config = function()
		--     vim.g.zenbones_darken_comments = 45
		--     vim.cmd.colorscheme('zenbones')
		-- end
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			local MiniStarter = require("mini.starter")

			-- Helper function to expand ~
			local function expand_path(path)
				return path:gsub("^~", os.getenv("HOME"))
			end

			-- Helper to get subdirectories
			local function get_subdirs(path)
				local expanded = expand_path(path)
				local result = {}
				for item in vim.fs.dir(expanded) do
					local full_path = expanded .. "/" .. item
					if vim.fn.isdirectory(full_path) == 1 then
						table.insert(result, {
							name = item,
							path = full_path,
						})
					end
				end
				table.sort(result, function(a, b) return a.name < b.name end)
				return result
			end

			-- Build project items
			local work_projects = get_subdirs("~/dev/gh-work")
			local personal_projects = get_subdirs("~/dev/gh-me")

			-- Build org file items
			local org_files = {}
			local org_path = expand_path("~/Dropbox/org")
			if vim.fn.isdirectory(org_path) == 1 then
				for item in vim.fs.dir(org_path) do
					if item:match("%.org$") then
						table.insert(org_files, {
							name = item:gsub("%.org$", ""),
							path = org_path .. "/" .. item,
						})
					end
				end
				table.sort(org_files, function(a, b) return a.name < b.name end)
			end

			-- Build a flat list of starter items for a group of {name, path}
			-- entries, tagged with the given section name and icon.
			local function build_items(entries, section, icon)
				local result = {}
				for _, entry in ipairs(entries) do
					table.insert(result, {
						name = icon .. " " .. entry.name,
						action = function() vim.cmd("edit " .. vim.fn.fnameescape(entry.path)) end,
						section = section,
					})
				end
				return result
			end

			-- Nerd Font icon glyphs, written as explicit UTF-8 byte escapes
			-- since LuaJIT's \u{} unicode escape isn't supported and raw
			-- private-use-area glyphs don't survive plain-text copy/paste.
			local icon_new_file = "\239\133\156" -- nf-fa-file_text
			local icon_quit = "\239\128\145" -- nf-fa-power_off
			local icon_folder = "\239\129\187" -- nf-fa-folder
			local icon_lightbulb = "\239\131\171" -- nf-fa-lightbulb_o
			local icon_note = "\239\137\137" -- nf-fa-sticky_note

			-- Build items list
			local items = {
				{ name = icon_new_file .. " New file", action = "enew", section = "Quick Actions" },
				{ name = icon_quit .. " Quit", action = "qa", section = "Quick Actions" },
			}

			vim.list_extend(items, build_items(work_projects, "Work Projects", icon_folder))
			vim.list_extend(items, build_items(personal_projects, "Personal Projects", icon_lightbulb))
			vim.list_extend(items, build_items(org_files, "Org Files", icon_note))

			-- Quotes shown at random as the splash header. Add more here.
			local quotes = {
				"a little every day, without hope, without despair — Isak Dinesen",
				"fundamental accuracy of statement is the ONE sole morality of writing — Ezra Pound",
			}

			MiniStarter.setup({
				evaluate_single = true,
				items = items,
				header = function()
					return quotes[math.random(#quotes)]
				end,
				content_hooks = {
					MiniStarter.gen_hook.adding_bullet(),
					MiniStarter.gen_hook.indexing("all", { "Quick Actions" }),
					MiniStarter.gen_hook.aligning("center", "center"),
				},
			})

			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- convenient text moving
			require("mini.move").setup()

			-- leap-like motions
			require("mini.jump2d").setup()

			-- indentation scope visualization
			require("mini.indentscope").setup({
				symbol = "│",
			})

			-- oil-like file editing
			require("mini.files").setup()
			vim.keymap.set("n", "<localleader>.", function()
				require("mini.files").open()
			end)

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
