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

-- lua function to toggle copilot
local suggest_status, suggest = pcall(require, "copilot.suggestion")
if not suggest_status then
	return
end

-- lua function to toggle Copilot auto-trigger
local function copilot_suggest()
	suggest.toggle_auto_trigger()
end

-- create the vim command
vim.api.nvim_create_user_command("CopilotSuggest", copilot_suggest, {})

-- set keymap to vim command
vim.api.nvim_set_keymap("n", "<leader>cs", ":CopilotSuggest<CR>", { noremap = true, silent = true })
