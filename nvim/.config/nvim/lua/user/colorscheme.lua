vim.cmd [[
try
  colorscheme base16-dark-seasmells
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
