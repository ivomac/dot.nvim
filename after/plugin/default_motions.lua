
-- Use j and k to move visually up and down
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- vim.keymap.set({"n", "v", "o"}, ",", ";")
-- vim.keymap.set({"n", "v", "o"}, ";", ",")

-- Center the screen on the cursor position after jumping
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep the cursor in the same position when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Jump backwards on tags (<C-]> is jump forward by default)
vim.keymap.set("n", "<C-[>", "<C-T>")

-- do not add jumps to the jump list with paragraph motions
parens_list = { "{", "}", "(", ")" }
for i=1,4 do
	vim.keymap.set("n", parens_list[i],
		function()
			vim.cmd("keepjumps norm! " .. vim.v.count1 .. parens_list[i])
		end,
		{silent=true}
	)
end
