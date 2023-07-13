vim.cmd [[
try
  colorscheme base16-green-moon-jai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
