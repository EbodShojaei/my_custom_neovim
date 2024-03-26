local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")

local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, -- black
	},
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = lualine_nightfly,
	},
	sections = {
		lualine_x = {
			{
				"copilot",
				-- Default values
				symbols = {
					status = {
						icons = {
							enabled = "",
							sleep = "󰒲", -- auto-trigger disabled
							disabled = "",
							warning = "",
							unknown = " ",
						},
						hl = {
							enabled = "#50FA7B",
							sleep = "#AEB7D0",
							disabled = "#6272A4",
							warning = "#FFB86C",
							unknown = "#FF5555",
						},
					},
					spinners = require("copilot-lualine.spinners").dots,
					spinner_color = "#6272A4",
				},
				show_colors = false,
				show_loading = true,
			},
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})
