return {

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			vim.treesitter.language.register('bash', 'zsh')
			vim.treesitter.language.register('bash', 'sh')
			configs.setup({
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = false,
				},
				matchup = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						selection_modes = {
							["@function.outer"]    = "V",
							["@conditional.outer"] = "V",
							["@class.outer"]       = "V",
							["@loop.outer"]        = "V",
							["@comment.outer"]     = 'V',
							["@block.outer"]       = "V",
						},
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ar"] = "@return.outer",
							["ir"] = "@return.inner",
							["a="] = "@assignment.outer",
							["i="] = "@assignment.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]a"] = "@parameter.outer",
							["]b"] = "@block.outer",
							["]c"] = "@class.outer",
							["]f"] = "@function.outer",
							["]i"] = "@conditional.outer",
							["]l"] = "@loop.outer",
							["]o"] = "@comment.outer",
							["]r"] = "@return.outer",
							["]="] = "@assignment.outer",
						},
						goto_next_end = {
							["]C"] = "@class.outer",
							["]F"] = "@function.outer",
							["]I"] = "@conditional.outer",
							["]R"] = "@return.outer",
						},
						goto_previous_start = {
							["[a"] = "@parameter.outer",
							["[b"] = "@block.outer",
							["[c"] = "@class.outer",
							["[f"] = "@function.outer",
							["[i"] = "@conditional.outer",
							["[l"] = "@loop.outer",
							["[o"] = "@comment.outer",
							["[r"] = "@return.outer",
							["[="] = "@assignment.outer",
						},
						goto_previous_end = {
							["[C"] = "@class.outer",
							["[F"] = "@function.outer",
							["[I"] = "@conditional.outer",
							["[R"] = "@return.outer",
						},
					},
				},
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{
		"yanskun/nvim-treesitter-context",
		branch = "fix/minus-row-selected",
		-- "nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = {"TSContextToggle"},
		opts = {
			max_lines = 3,
			min_window_height = 22,
		},
		keys = {
			{ "[[", function() require("treesitter-context").go_to_context(vim.v.count1) end, silent = true, "Go to context" },
			{ "=s", function() vim.cmd.TSContextToggle() end, silent = true, "Toggle scope context" },
		},
	},

}
