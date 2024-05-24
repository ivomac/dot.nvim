
local group = vim.api.nvim_create_augroup("FT_DETECT", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.zsh",
	callback = function() vim.cmd.setfiletype("zsh") end,
	group = group,
})

