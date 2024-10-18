
vim.opt_local.makeprg = "latexmk -interaction=nonstopmode %"

vim.opt_local.wrap = true

vim.api.nvim_create_user_command("View",
	function()
		local path = vim.fn.expand("%:p")
		local pdf = string.gsub(path, ".tex", ".pdf")
		local server = vim.v.servername
		local cmd = "silent !okular --editor-cmd 'nvim --server " .. server  .. " --remote-send <Esc>\\%lgg' " .. pdf .. " &"
		vim.cmd(cmd)
	end,
	{ }
)


vim.api.nvim_create_autocmd({"VimLeavePre"}, {
	buffer = 0,
	callback = function()
		vim.cmd("!cleantex")
	end,
})

