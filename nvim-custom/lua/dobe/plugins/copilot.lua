local copilot_status, copilot = pcall(require, "copilot")
if not copilot_status then
	print("Error loading copilot config")
	return
end
print("Copilot loaded")

copilot.setup({
	panel = {
		enabled = true,
		auto_refresh = false,
		keymap = {
			accept = "<CR>",
			jump_prev = "[[",
			jump_next = "]]",
			refresh = "gr",
			open = "<C-l>",
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = false,
		keymap = {
			accept = "<M-l>",
			prev = "<M-[>",
			next = "<C-]>",
			dismiss = "<C-c>",
		},
	},
	copilot_node_command = "node", -- Node.js version must be > 18.x
	server_opts_overrides = {},
})

vim.g.copilot_assume_mapped = true
