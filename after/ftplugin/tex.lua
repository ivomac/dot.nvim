
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


local tex_trash = {
	"*.run.xml",
	"*Notes.bib",
	"*.aux",
	"*.brf",
	"*.nav",
	"*.snm",
	"*.lof",
	"*.log",
	"*.lot",
	"*.fls",
	"*.out",
	"*.toc",
	"*.fmt",
	"*.fot",
	"*.cb",
	"*.cb2",
	"*.lb",
	"*.bbl",
	"*.bcf",
	"*.blg",
	"*.fdb_latexmk",
	"*.synctex",
	"*.synctex(busy)",
	"*.synctex.gz",
	"*.synctex.gz(busy)",
	"*.pdfsync",
	"*.end",
}

for _, trash in ipairs(tex_trash) do
	vim.api.nvim_create_autocmd({"VimLeavePre"}, {
		pattern = ".tex",
		callback = function()
			vim.cmd("silent !rm -f -- " .. trash)
		end,
	})
end

