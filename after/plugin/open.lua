
vim.keymap.set("n", "<CR>",
	function()
		if vim.bo.buftype == "quickfix" then
			key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
			vim.api.nvim_feedkeys(key, "nt", false)
		else
			vim.cmd("silent !$OPEN <cfile>")
		end
	end,
	{ silent = true, desc = "Open files/links" }
)

vim.keymap.set("x", "<CR>",
	function()
		local text = GetVisual()
		vim.cmd("silent !$OPEN " .. text)
	end,
	{ silent = true, desc = "Open files/links" }
)

GetVisual = function()
	vim.fn.feedkeys(":", "nx")
	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")
	local line_start = vstart[2]
	local column_start = vstart[3]
	local line_end = vend[2]
	local column_end = vend[3]
	local lines = vim.fn.getline(line_start, line_end)
	if #lines == 0 then
		return ""
	elseif #lines == 1 then
		return lines[1]:sub(column_start, column_end)
	end
	lines[1] = lines[1]:sub(column_start, #lines[1])
	local off = vim.o.selection ~= "inclusive" and 2 or 1
	lines[#lines] = lines[#lines]:sub(1, column_end - off)
	local text = table.concat(lines, "\r")
	return text
end
