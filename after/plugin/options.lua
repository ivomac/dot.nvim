HOME = os.getenv("HOME")

vim.opt.hidden = true
vim.opt.path:append("**")
vim.opt.autoread = true
vim.opt.nrformats = { "bin", "hex", "alpha" }
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 9999
vim.opt.timeout = true
vim.opt.timeoutlen = 9999
vim.opt.autowriteall = true
vim.opt.virtualedit = "block"

vim.opt.viewoptions = { "cursor", "folds", "slash", "unix" }

vim.opt.completeopt = "menu"
vim.opt.cpoptions = "aBcFn_"

vim.opt.tags = { "./.git/tags;/", "./.tags;/" }

vim.opt.commentstring = "# %s"

vim.opt.wildignore:append({ ".git", ".gitignore" })
vim.opt.matchpairs:append("<:>")
vim.opt.history = 1000
vim.opt.backup = true
vim.opt.swapfile = false

vim.opt.writebackup = true
vim.opt.backupdir = HOME .. "/.cache/tmp"
vim.opt.directory = HOME .. "/.cache/tmp"
vim.opt.updatetime = 500
vim.opt.undodir = HOME .. "/.local/share/nvim/undo"

vim.opt.undolevels = 1000
vim.opt.undofile = true
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "0"
vim.opt.foldnestmax = 2
vim.opt.signcolumn = "yes:1"
vim.opt.shortmess = "taoOWTF"
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.tabpagemax = 20
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.relativenumber = false
vim.opt.number = false
vim.opt.numberwidth = 1
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.breakindent = true
vim.opt.sidescroll = 8
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.display:append("lastline")
vim.opt.showcmd = true
vim.opt.showbreak = "…"
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", extends = "»", precedes = "«", nbsp = "•", eol = "¬" }
vim.opt.fillchars = { stl = " ", stlnc = " ", fold = " ", vert = "│", eob = "~" }
vim.opt.linebreak = true
vim.opt.autoindent = false
vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.indentkeys = { "o", "O" }
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"
vim.opt.redrawtime = 400

vim.opt.cursorline = true
vim.opt.formatoptions = "j"

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.opt_local.cursorline = true
		vim.opt_local.formatoptions = "j"
	end
})

-- Create an autocommand group to avoid adding multiple autocommands
local group = vim.api.nvim_create_augroup("ReturnToLastPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	pattern = "*",
	callback = function()
		local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
		if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, { row, col })
		end
	end
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = { "*" },
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
