
vim.g.python_indent = {
	disable_parentheses_indenting = false,
	closed_paren_align_last_line = false,
	searchpair_timeout = 150,
	continue = 'shiftwidth()',
	open_paren = 'shiftwidth()',
	nested_paren = 'shiftwidth()'
}

vim.opt_local.indentkeys = { 'o', 'O' }
