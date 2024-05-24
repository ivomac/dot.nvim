-- change windows with <M-hjkl>
vim.keymap.set("n", "<M-h>", "<C-w>h", {desc="To Left Window"})
vim.keymap.set("n", "<M-j>", "<C-w>j", {desc="To Lower Window"})
vim.keymap.set("n", "<M-k>", "<C-w>k", {desc="To Upper Window"})
vim.keymap.set("n", "<M-l>", "<C-w>l", {desc="To Right Window"})

-- Resize windows with <C-M-hjkl>
vim.keymap.set("n", "<C-M-h>", "<C-w>2<", {desc="Resize Window"})
vim.keymap.set("n", "<C-M-j>", "<C-w>2+", {desc="Resize Window"})
vim.keymap.set("n", "<C-M-k>", "<C-w>2-", {desc="Resize Window"})
vim.keymap.set("n", "<C-M-l>", "<C-w>2>", {desc="Resize Window"})

-- Exit terminal mode with <C-\>, go back directly with <C-h>
vim.keymap.set("t", "<C-\\>", "<C-\\><C-N>", {desc="Exit TermMode"})
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", {desc="Exit TermMode and go winleft"})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd.startinsert()
	end
})
