return {

	{
		"simnalamburt/vim-mundo",
		cmd={"MundoToggle"},
		keys={
			{"<leader>u", vim.cmd.MundoToggle, desc="Toggle undo tree"},
		},
	},

	{ "nvim-tree/nvim-web-devicons" },
	{ "sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cmd = { "Gitsigns" },
		opts = {
			signcolumn = true,
			numhl      = true,
			linehl     = false,
			auto_attach = true,
			current_line_blame = false,
			max_file_length = 1000,
		},
		keys = {
			{"=gl",        function() require("gitsigns").toggle_linehl()             end , desc = "Toggle line highlight" },
			{"=gb",        function() require("gitsigns").toggle_current_line_blame() end , desc = "Toggle blame" },
			{"=gd",        function() require("gitsigns").toggle_deleted()            end , desc = "Toggle deleted" },
			{"=gw",        function() require("gitsigns").toggle_word_diff()          end , desc = "Toggle word diff" },
			{"[h",         function() require("gitsigns").nav_hunk("prev")            end , desc = "Navigate previous hunk" },
			{"]h",         function() require("gitsigns").nav_hunk("next")            end , desc = "Navigate next hunk" },
			{"gh",         function() require("gitsigns").preview_hunk()              end , desc = "Preview hunk" },
			{"grh",        function() require("gitsigns").reset_hunk()                end , desc = "Reset hunk", mode = {"n", "v"}},
			{"gsh",        function() require("gitsigns").stage_hunk()                end , desc = "Stage hunk", mode = {"n", "v"}},
			{"gsu",        function() require("gitsigns").undo_stage_hunk()           end , desc = "Undo stage hunk", mode = {"n", "v"}},
		},
	},

}
