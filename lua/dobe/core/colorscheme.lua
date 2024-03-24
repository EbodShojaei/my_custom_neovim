local status, _ = pcall(vim.cmd, "colorscheme nightfly") -- Protected call in case theme not installed
if not status then
  print("Colorscheme not found!")
  return
end

