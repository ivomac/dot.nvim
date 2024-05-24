
local fzf_fd_command = os.getenv("FZF_FD_COMMAND") or "fd "
local fzf_rg_command = os.getenv("FZF_RG_COMMAND") or "rg "

-- remove "fd" and "rg" from beginning of the commands

fzf_fd_command = fzf_fd_command:gsub("^fd ", "") .. " --type f"
fzf_rg_command = fzf_rg_command:gsub("^rg ", "") .. " --files"


return {

	{
		"luukvbaal/nnn.nvim",
		lazy = false,
		cmd = { "NnnPicker" },
		opts = {
			picker = {
				cmd = "nnn -Ac -s nnn", -- command override (-p flag is implied)
				style = {
					width = 0.9, -- percentage relative to terminal size when < 1, absolute otherwise
					height = 0.8,
					xoffset = 0.5,
					yoffset = 0.5,
					border = "rounded"
				},
				session = "local", -- or "global" / "local" / "shared"
				tabs = true, -- separate nnn instance per tab
				fullscreen = true, -- whether to fullscreen picker window when current tab is empty
			},
			auto_open = {
				setup = false, -- or "explorer" / "picker", auto open on setup function
				tabpage = "picker", -- or "explorer" / "picker", auto open when opening new tabpage
				empty = true, -- only auto open on empty buffer
			},
			auto_close = true, -- close tabpage/nvim when nnn is last window
			replace_netrw = "picker", -- or "explorer" / "picker"
			windownav = {    -- window movement mappings to navigate out of nnn
				left = "<C-w>h",
				right = "<C-w>l",
			},
			buflisted = false, -- whether or not nnn buffers show up in the bufferlist
			quitcd = nil, -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
			offset = false, -- whether or not to write position offset to tmpfile(for use in preview-tui)
		},
		keys = {
			{ "<leader>a", function() vim.cmd.NnnPicker("%:p:h") end, desc = "NNN in buf folder" },
			{ "<leader>s", function() vim.cmd.NnnPicker() end,        desc = "NNN picker" },
		},
	},

	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			files = {
				fd_opts = fzf_fd_command,
				rg_opts = fzf_rg_command,
			},
		},
		keys = {
			{ "<leader><leader>", function() require("fzf-lua").resume() end,                        silent = true, desc = "Last FZF" },
			{ "<leader>f",       function() require("fzf-lua").files() end,                          silent = true, desc = "Files" },
			{ "<leader>o",       function() require("fzf-lua").oldfiles({ resume = true }) end,      silent = true, desc = "Opened Files" },
			{ "<leader>h",       function() require("fzf-lua").git_files() end,                      silent = true, desc = "Git Files" },
			{ "<leader>d",       function() require("fzf-lua").grep() end,                           silent = true, desc = "Grep" },
			{ "<leader>d",       function() require("fzf-lua").grep_visual() end,                    silent = true, desc = "Grep Visual", mode = "x" },
			{ "<leader>l",       function() require("fzf-lua").live_grep() end,                      silent = true, desc = "Live Grep" },
			{ "<leader>k",       function() require("fzf-lua").helptags() end,                       silent = true, desc = "Help Tags" },
			{ "<leader>j",       function() require("fzf-lua").buffers() end,                        silent = true, desc = "Buffers" },
			{ "<leader>q",       function() require("fzf-lua").quickfix() end,                       silent = true, desc = "Quickfix" },
		},
	},

}
