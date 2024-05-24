vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("ftdetect")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	{
		{ import = "plugin" },
		{ import = "ftplugin" },
	},
	{
		change_detection = {
			enabled = false,
		}
	}
)

dofile(vim.fn.stdpath("config") .. "/after/colors/default.lua")
