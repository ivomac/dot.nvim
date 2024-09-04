
local function split(inputstr, sep)
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local function select_block()
	local cs = vim.api.nvim_buf_get_option(0, "commentstring")

	if cs == "" then
		return
	end

	first_cs = split("^" .. cs, "%s")[1]

	local top = vim.fn.search(first_cs, 'nb')

	local bot = vim.fn.search(first_cs, 'n')

	if top == 0 or bot == 0 then
		return
	end

	vim.api.nvim_win_set_cursor(0, {top + 1, 0})
	vim.cmd([[normal V]])
	vim.api.nvim_win_set_cursor(0, {bot - 1, 0})
end

vim.keymap.set("n", "<C-k>", select_block, {silent=true})

