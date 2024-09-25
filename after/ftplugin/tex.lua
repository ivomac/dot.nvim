
vim.opt_local.makeprg = "latexmk -interaction=nonstopmode %"

vim.opt_local.wrap = true
vim.opt_local.spell = true

-- create command to open pdf

vim.api.nvim_create_user_command("View",
	function()
		local path = vim.fn.expand("%:p")
		-- change extension
		path = string.gsub(path, ".tex", ".pdf")
		vim.cmd("silent !xdg-open " .. path .. " &")
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

