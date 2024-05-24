
function CreateTitle()
	local SEP = "⠀" -- U+2800 BRAILLE PATTERN BLANK

	local cwd = vim.fn.getcwd()
	local pwd = string.gsub(cwd, vim.fn.expand("$HOME"), "~")
	cwd = cwd .. "/"

	local current_buf = vim.fn.expand("%:p")
	local current_buf_name = vim.fn.expand("%:t")

	local line = vim.fn.getline(".")

	local buf_info = vim.fn.getbufinfo({ buflisted = true })
	local buf_list = {}
	local lastused = ""
	for _, buf in ipairs(buf_info) do
		if buf.name == current_buf then
			lastused = os.date("%H:%M", buf.lastused)
		else
			local name = string.gsub(buf.name, cwd, "")
			table.insert(buf_list, name)
		end
	end
	local buf_names = table.concat(buf_list, SEP)
	if #buf_names > 0 then
		buf_names = string.format("other bufs:%s%s", SEP, buf_names)
	end

	-- guillemets:  »
	local title_format = "NVIM %s%s» %s%s%s%s« %s%s%s"
	local title = string.format(
		title_format,
		pwd, SEP,
		current_buf_name, SEP,
		line, SEP,
		lastused, SEP,
		buf_names
	)
	return title
end

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = "%{v:lua.CreateTitle()}"
