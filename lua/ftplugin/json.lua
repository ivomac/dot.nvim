return {

	{ "elzr/vim-json",
		ft = { "json" },
		config = function()
			vim.g.vim_json_syntax_conceal=0
			vim.g.vim_json_conceal=0
		end,
	},

}
