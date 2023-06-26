vim.cmd [[
try
  colorscheme base16-rose-pine 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
