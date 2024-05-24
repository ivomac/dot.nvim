
vim.opt_local.conceallevel = 0

-- set keymap to format json with jq
vim.api.nvim_buf_set_keymap(0,
	'n', 'gqq', ':%!jq "."<CR>', { silent = true })
