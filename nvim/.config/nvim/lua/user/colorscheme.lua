vim.cmd [[
try
  colorscheme randombones
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
