local dark_art_deco = {
	base00 = "#100C08",
	base01 = "#16161D",
	base02 = "#ca9ee6",
	base03 = "#2c434e",
	base04 = "#303446",
	base05 = "#ffffff",
	base06 = "#c6d0f5",
	base07 = "#e7d6da",
	base08 = "#babbf1",
	base09 = "#eebebe",
	base0A = "#85c1dc",
	base0B = "#e5c890",
	base0C = "#81c8be",
	base0D = "#f2d5cf",
	base0E = "#99d1db",
	base0F = "#99d1db",
}
require("mini.base16").setup({ palette = dark_art_deco })
vim.cmd("set cursorlineopt=number ")
vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")
vim.cmd("hi! LineNRBelow ctermbg=NONE guibg=NONE")
vim.cmd("hi! LineNRAbove ctermbg=NONE guibg=NONE")
vim.cmd("hi! SignColumn ctermbg=NONE guibg=NONE")
vim.cmd("hi! GitSignsAdd ctermbg=NONE guibg=NONE")
vim.cmd("hi! GitSignsChange ctermbg=NONE guibg=NONE")
vim.cmd("hi! GitSignsDelete ctermbg=NONE guibg=NONE")
vim.cmd("hi! DiagnosticSignError ctermbg=NONE guibg=NONE")
vim.cmd("hi! DiagnosticSignWarn ctermbg=NONE guibg=NONE")
vim.cmd("hi! DiagnosticSignHint ctermbg=NONE guibg=NONE")
vim.cmd("hi! DiagnosticSignInfo ctermbg=NONE guibg=NONE")
vim.cmd("hi! MsgArea ctermbg=NONE guibg=NONE")
