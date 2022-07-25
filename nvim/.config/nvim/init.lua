require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.venn"
require "user.zenmode"
--extra plugins
--require "user.bookmarks"

--read quarto markdown as regular markdown TODO: move this out of here
vim.cmd[[autocmd BufRead,BufNew,BufNewFile *.qmd setlocal ft=markdown]]
--detect tweego filetype
vim.cmd[[autocmd BufRead,BufNew,BufNewFile *.tw, *twee setlocal ft=tweego]]
