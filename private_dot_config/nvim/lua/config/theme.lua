vim.o.termguicolors = true

-- Follow the GNOME desktop light/dark preference for the colorscheme,
-- since zenwritten looks best when it matches the OS theme.
local function system_prefers_dark()
	local ok, result = pcall(vim.fn.system, { "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
	if ok and vim.v.shell_error == 0 and result:match("prefer%-dark") then
		return true
	end
	return false
end

local function apply_background()
	vim.o.background = system_prefers_dark() and "dark" or "light"
end

apply_background()
vim.cmd.colorscheme("zenwritten")

-- Re-check the OS theme whenever Neovim regains focus, so toggling
-- light/dark mode on the desktop is picked up without restarting.
vim.api.nvim_create_autocmd("FocusGained", {
	callback = function()
		local before = vim.o.background
		apply_background()
		if vim.o.background ~= before then
			vim.cmd.colorscheme("zenwritten")
		end
	end,
})
