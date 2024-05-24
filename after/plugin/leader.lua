local suffix = "egi<Left><Left><Left><Left>"

vim.keymap.set("n", "<leader>/", ":%s:\\::" .. suffix .. "<Left>", { desc = "Replace in %" })
vim.keymap.set("x", "<leader>/", ":s:\\::" .. suffix .. "<Left>", { desc = "Replace in sel." })

vim.keymap.set("n", "<leader>r", ":'{,'}s:\\V\\<<c-r><c-w>\\>::" .. suffix, { desc = "Replace word in {}" })
vim.keymap.set("n", "<leader>R", ":%s:\\V\\<<c-r><c-w>\\>::" .. suffix, { desc = "Replace word in %" })

vim.keymap.set("x", "<leader>r", "y:'{,'}s:\\V<c-r>\"::" .. suffix, { desc = "Replace sel. in {}" })
vim.keymap.set("x", "<leader>R", "y:%s:\\V<c-r>\"::" .. suffix, { desc = "Replace sel. in %" })

vim.keymap.set("n", "<leader>w", ":%s:\\s\\+$::<CR>", { desc = "Remove trailing \\s" })
vim.keymap.set("x", "<leader>w", ":s:\\s\\+$::<CR>", { desc = "Remove trailing \\s" })

vim.keymap.set("n", '<leader>"', 'mz:%v:": s:\':":egi<CR>`zzz', { desc = "Replace '' -> \"\"" })
vim.keymap.set("n", "<leader>'", "mz:%v:': s:\":':egi<CR>`zzz", { desc = 'Replace "" -> \'\'' })

vim.api.nvim_create_user_command("To",
	function(opts)
		local dest = opts.fargs[1]
		local dest_path = ""
		if dest == "parent" then
			dest_path = ".."
		elseif dest == "current" then
			dest_path = vim.fn.expand("%:p:h")
		elseif dest == "git" then
			local dot_git_path = vim.fn.finddir(".git", ".;")
			dest_path = vim.fn.fnamemodify(dot_git_path, ":h")
		end
		vim.cmd.cd(dest_path)
		vim.cmd.pwd()
	end,
	{ nargs = 1 }
)

vim.keymap.set("n", '<leader>p', function() vim.cmd.To("current") end, { desc = "cd to %" })
vim.keymap.set("n", '<leader>.', function() vim.cmd.To("parent") end, { desc = "cd to .." })
vim.keymap.set("n", '<leader>gp', function() vim.cmd.To("git") end, { desc = "cd to .git" })

vim.api.nvim_create_user_command("Rename",
	function(opts)
		local name = vim.fn.expand("%:p")
		local folder = vim.fn.expand("%:p:h")
		local new_name = folder .. "/" .. opts.fargs[1]
		os.rename(name, new_name)
		vim.cmd("e " .. new_name)
		vim.cmd("bd #")
		print("mv -> " .. new_name)
	end,
	{ nargs = 1 }
)

vim.api.nvim_create_user_command("Remove",
	function()
		os.remove(vim.fn.expand("%:p"))
		vim.cmd("bd")
		print("rm %")
	end,
	{ nargs = 0 }
)

vim.api.nvim_create_user_command("Chmod",
	function(opts)
		vim.cmd("silent !chmod " .. opts.fargs[1] .. " %")
		print("chmod +x %")
	end,
	{ nargs = 1 }
)
vim.keymap.set("n", "<leader>*", function() vim.cmd.Chmod("+x") end, { desc = "Make Executable" })

vim.keymap.set("n", "<leader>M", function() vim.cmd("silent make | copen") end, { desc = "Make" } )
vim.keymap.set("n", "<leader>e", function() vim.cmd("term '%:p'") end, { desc = "Run current program" })
