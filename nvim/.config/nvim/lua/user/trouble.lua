local status_ok, trouble = pcall(require, 'trouble')
if not status_ok then
  return
end

trouble.setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 5, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
})
