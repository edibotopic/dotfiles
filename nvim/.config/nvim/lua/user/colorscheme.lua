vim.cmd [[
try
  colorscheme neobones
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
