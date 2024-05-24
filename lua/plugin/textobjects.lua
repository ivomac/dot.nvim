return {

	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			local keymap = vim.keymap.set

			keymap({ "o", "x" }, "i<Tab>", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", {desc="in Indent"})
			keymap({ "o", "x" }, "a<Tab>", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", {desc="an Indent"})
			keymap({ "o", "x" }, "a<S-Tab>", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>", {desc="outer Indent"})

			keymap({ "o", "x" }, "iu", "<cmd>lua require('various-textobjs').subword('inner')<CR>", {desc="in Subword"})
			keymap({ "o", "x" }, "au", "<cmd>lua require('various-textobjs').subword('outer')<CR>", {desc="a  Subword"})

			keymap({ "o", "x" }, "aE", "<cmd>lua require('various-textobjs').entireBuffer()<CR>", {desc="a  Subword"})

			keymap({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", {desc="in Value"})
			keymap({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value('outer')<CR>", {desc="a Value"})

			keymap({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key('inner')<CR>", {desc="in Key"})
			keymap({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key('outer')<CR>", {desc="a Key"})

			keymap({ "o", "x" }, "in", "<cmd>lua require('various-textobjs').number('inner')<CR>", {desc="in Number"})
			keymap({ "o", "x" }, "an", "<cmd>lua require('various-textobjs').number('outer')<CR>", {desc="a Number"})

			keymap({ "o", "x" }, "im",
				"<cmd>lua require('various-textobjs').chainMember('inner')<CR>", {desc="in Method"}
			)
			keymap({ "o", "x" }, "am",
				"<cmd>lua require('various-textobjs').chainMember('outer')<CR>", {desc="a Method"}
			)

			keymap({ "o", "x" }, "iS",
				"<cmd>lua require('various-textobjs').pyTripleQuotes('inner')<CR>", {desc="in TripleQuotes"}
			)
			keymap({ "o", "x" }, "aS",
				"<cmd>lua require('various-textobjs').pyTripleQuotes('outer')<CR>", {desc="in TripleQuotes"}
			)

			keymap({ "o", "x" }, "iP",
				"<cmd>lua require('various-textobjs').shellPipe('inner')<CR>", {desc="in Pipe"}
			)
			keymap({ "o", "x" }, "aP",
				"<cmd>lua require('various-textobjs').shellPipe('outer')<CR>", {desc="a Pipe"}
			)

			keymap({ "o", "x" }, "ix",
				"<cmd>lua require('various-textobjs').htmlAttribute('inner')<CR>", {desc="in HTMLAttr"}
			)
			keymap({ "o", "x" }, "ax",
				"<cmd>lua require('various-textobjs').htmlAttribute('outer')<CR>", {desc="an HTMLAttr"}
			)
		end,
	},

	{ "kana/vim-textobj-user" },

	{
		"glts/vim-textobj-comment",
		dependencies = { "kana/vim-textobj-user" },
		config = function()
			vim.g.textobj_comment_no_default_key_mappings = 1
		end,
		keys = {
			{ "ao", "<Plug>(textobj-comment-a)",     mode = { "x", "o" }, remap = true, silent = true, desc = "a Comment" },
			{ "io", "<Plug>(textobj-comment-i)",     mode = { "x", "o" }, remap = true, silent = true, desc = "in Comment" },
			{ "aO", "<Plug>(textobj-comment-big-a)", mode = { "x", "o" }, remap = true, silent = true, desc = "a Comment + \\s" },
		}
	},

	{
		"ivomac/textobj-word-column.vim",
		event = "VeryLazy",
		dependencies = { "kana/vim-textobj-user" },
	},

}
