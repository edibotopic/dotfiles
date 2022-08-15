vim.cmd [[
try
  colorscheme synthwave84 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
