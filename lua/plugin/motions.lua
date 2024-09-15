return {

	{
		"andymass/vim-matchup",
		config = function()
			vim.g.loaded_matchparen = 1
			vim.g.loaded_matchit = 1
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			labels = "djfhskeialwocvbngmru",
			-- default
			search = {
				mode = "search",
				multi_window = true,
				wrap = true,
				incremental = false,
				max_length = 2,
			},
			jump = {
				pos = "start",
				autojump = true,
				jumplist = true,
				history = false,
				register = true,
				nohlsearch = true,
				offset = nil,
			},
			label = {
				uppercase = true,
				exclude = "",
				current = true,
				after = false,
				before = true,
				style = "overlay",
				reuse = "all",
				distance = true,
				min_pattern_length = 2,
				rainbow = { enabled = false },
			},
			highlight = {
				backdrop = false,
				matches = true,
				groups = {
					match = "Search",
					current = "IncSearch",
					label = "Cursor",
				},
			},
			modes = {
				-- a regular search with `/` or `?`
				search = {
					labels = "DJFHSKEIALWOCVBNGMRU",
					enabled = true,
					search = {
						mode = "fuzzy",
						multi_window = true,
						wrap = true,
						incremental = false,
						max_length = false,
					},
					jump = {
						pos = "start",
						autojump = false,
						jumplist = true,
						history = true,
						register = true,
						nohlsearch = true,
						offset = nil,
					},
					label = {
						uppercase = false,
						exclude = "",
						current = true,
						after = false,
						before = true,
						style = "eol",
						reuse = "all",
						distance = true,
						min_pattern_length = 6,
						rainbow = { enabled = false },
					},
					highlight = {
						backdrop = false,
						matches = true,
						groups = {
							match = "Search",
							current = "IncSearch",
							label = "Cursor",
						},
					},
				},
				-- `f`, `F`, `t`, `T`, `;` and `,` motions
				char = {
					labels = "JHKELWOBNGMRU",
					enabled = true,
					autohide = true,
					jump_labels = true,
					multi_line = true,
					keys = { "f", "F", "t", "T", ";", "," },
					config = function(opts)
						opts.jump_labels = opts.jump_labels
						and vim.v.count == 0
						and vim.fn.reg_executing() == ""
						and vim.fn.reg_recording() == ""
						and not vim.fn.mode(true):find("o")
						-- opts.multi_line = opts.multi_line
						-- and not vim.fn.mode(true):find("o")
					end,
					char_actions = function()
						return {
							[";"] = "prev",
							[","] = "next",
						}
					end,
					search = {
						mode = "exact",
						multi_window = false,
						wrap = false,
						incremental = false,
						max_length = 1,
					},
					jump = {
						pos = "start",
						autojump = false,
						jumplist = true,
						history = false,
						register = false,
						nohlsearch = false,
						offset = nil,
					},
					label = {
						uppercase = false,
						exclude = "",
						after = false,
						before = true,
						style = "overlay",
						reuse = "all",
						distance = true,
						min_pattern_length = 1,
						rainbow = { enabled = false },
					},
					highlight = {
						backdrop = false,
						matches = true,
						groups = {
							match = "Search",
							label = "IncSearch",
						},
					},
				},
				treesitter = {
					labels = "djfhskeialwobngmruqptyvcxz",
					search = {
						mode = "exact",
						multi_window = true,
						wrap = true,
						incremental = false,
						max_length = 2,
					},
					jump = {
						pos = "range",
						autojump = true,
						jumplist = true,
						history = false,
						register = true,
						nohlsearch = true,
						offset = nil,
					},
					label = {
						uppercase = true,
						exclude = "",
						after = false,
						before = true,
						style = "overlay",
						reuse = "all",
						distance = true,
						min_pattern_length = 1,
						rainbow = { enabled = false },
					},
					highlight = {
						backdrop = false,
						matches = false,
						groups = {
							match = "Search",
							current = "IncSearch",
							label = "Cursor",
						},
					},
				},
			},
		},
		keys = {
			{ "\\",    mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Move with labels" },
			{ "<Bar>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Select Treesitter node" },
		},
	},

}
