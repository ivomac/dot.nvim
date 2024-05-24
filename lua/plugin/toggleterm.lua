return {

	{
		"akinsho/toggleterm.nvim",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 16
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			shading_factor = 0,
			start_in_insert = false,
			insert_mappings = false,
			terminal_mappings = true,
			direction = "vertical",
			close_on_exit = true,
		},
		keys = {
			{ "<C-j><C-j>", 
				function()
					require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
				end,
				mode = { "x" },
				desc = "Send Selection to Term"
			},
			{ "<C-\\>", desc = "Toggle Term" },
		},
	},

}
