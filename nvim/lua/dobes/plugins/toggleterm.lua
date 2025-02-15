return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 15,
		open_mapping = [[<leader>tt]],
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = "1",
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		auto_scroll = true,
	},
}
