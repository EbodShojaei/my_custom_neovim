local status, _ = pcall(vim.cmd, "colorscheme tokyonight") -- Protected call in case theme not installed
if not status then
	print("Colorscheme not found!")
	return
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
