local ls = require("luasnip")
local extra = require("luasnip.extras")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = extra.lambda
local rep = extra.rep
local p = extra.partial
local m = extra.match
local n = extra.nonempty
local dl = extra.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local util = require("luasnip.util.util")


local function resolve_pair(pair)
	local Pair = { pair:sub(1, 1), pair:sub(2, 2) }
	local resPair = Pair
	if resPair[1] == "{" then
		resPair = { "{{", "}}" }
	end
	return Pair, resPair
end

local function make_pair_snip(pair)
	local _, resPair = resolve_pair(pair)
	local res = string.format("%s{}%s", resPair[1], resPair[2])
	return s(
		{
			trig = pair,
			name = "autojump to " .. pair,
			desc = "autojump to middle of " .. pair,
			wordTrig = false,
			hidden = true,
			snippetType = "autosnippet",
		},
		fmt(res, { i(1) })
	)
end

local function make_auto_open_pair_snip(pair)
	local Pair, resPair = resolve_pair(pair)

	local res = string.format([[
			%s
				{}
			%s
		]], resPair[1], resPair[2])

	return s(
		{
			trig = Pair[1],
			name = "auto open " .. pair,
			desc = "auto open " .. pair,
			hidden = true,
			priority = 5000,
			wordTrig = false,
			snippetType = "snippet",
			resolveExpandParams = function(snippet, line_to_cursor, matched_trigger, captures)
				local linenr, colnr = unpack(util.get_cursor_0ind())
				local char = vim.api.nvim_get_current_line():sub(colnr + 1, colnr + 1)
				if char == Pair[2] then
					return {
						clear_region = { from = { linenr, colnr - 1 }, to = { linenr, colnr + 1 } },
					}
				end
			end
		},
		fmt(res, { i(1, nil) })
	)
end

-- Helper function to get the comment prefix and suffix
local function get_comment_parts(part)
	local cs = vim.bo.commentstring
	-- Ensure '%s' is in the commentstring
	if not cs:find("%%s") then
		cs = cs .. " %s"
	end
	-- Extract prefix and suffix around '%s'
	if part == "prefix" then
		local pref = cs:match("^(.*)%%s") or "# "
		return pref .. "TODO(" .. os.getenv("USER") .. "): "
	elseif part == "suffix" then
		return cs:match("%%s(.*)$") or ""
	end
end

local todo = s(
	{
		trig = "todo",
		name = "TODO",
		desc = "TODO comment",
		snippetType = "snippet",
	},
	{
		f(function()
			return get_comment_parts("prefix")
		end),
		i(1, "Your comment here"),
		f(function()
			return get_comment_parts("suffix")
		end),
	}
)

local dated_todo = s(
	{
		trig = "dtodo",
		name = "TODO with date and user",
		desc = "generate a TODO comment with current date and writer name",
		snippetType = "snippet",
	},
	fmt(
		'{} {} TODO(ivo): {} {}',
		{
			f(function() return get_cstring()[1] end),
			t(string.format("ivomac-<%s>", os.date('%y-%m-%d'))),
			i(1, nil),
			f(function() return get_cstring()[2] end)
		}
	)
)

local date = s(
	{
		trig = "date",
		name = "date",
		desc = "insert current date",
		snippetType = "snippet",
	},
	t(os.date('%Y-%m-%d'))
)

local time = s(
	{
		trig = "time",
		name = "time",
		desc = "insert current time",
		snippetType = "snippet",
	},
	t(os.date('%H:%M:%S'))
)

local bang = s(
	{
		trig = "bang",
		name = "shebang",
		desc = "generate shebang line",
		snippetType = "snippet",
	},
	fmt("#!/usr/bin/{}",
		{
			i(1, nil),
		}
	)
)

local env = s(
	{
		trig = "env",
		name = "env shebang",
		desc = "generate shebang line with env",
		snippetType = "snippet",
	},
	fmt("#!/usr/bin/env {}",
		{
			i(1, nil),
		}
	)
)

-- A snippet to create a title surrounded by #s like in a box
-- The size of the box is determined by the length of the title

local function gen_box(args)
	local title = args[1][1]
	local title_len = string.len(title)
	local box_len = title_len + 8
	local box = string.rep("#", box_len)
	return sn(nil, { t(box) })
end

local titlebox = s(
	{
		trig = "box",
		name = "titlebox",
		desc = "create a titlebox",
		snippetType = "snippet",
	},
	{
		d(2, gen_box, { 1 }),
		t({ "", "### " }),
		i(1, "Title"),
		t({ " ###", "" }),
		d(3, gen_box, { 1 }),
		t({ "", "" }),
		i(0),
	}
)

ls.add_snippets("all",
	{
		make_pair_snip("()"),
		make_pair_snip("[]"),
		make_pair_snip("{}"),
		make_pair_snip("<>"),
		make_pair_snip("''"),
		make_pair_snip('""'),
		make_auto_open_pair_snip("()"),
		make_auto_open_pair_snip("[]"),
		make_auto_open_pair_snip("{}"),
		todo,
		dated_todo,
		date,
		time,
		bang,
		env,
		titlebox
	}
)

ls.add_snippets("tex",
	{
		make_pair_snip("$$"),
	}
)

local function dict_key_snip(value)
	return s(
		{
			trig = value,
			name = "dictionary item",
			desc = "define a key:value in a python dictionary",
			hidden = true,
			snippetType = "snippet",
		},
		fmt("{}: {},{}",
			{
				i(1, ""),
				i(2, ""),
				i(3, nil),
			}
		)
	)
end

local breakpoint = s(
	{
		trig = "bp",
		name = "breakpoint",
		desc = "add a python breakpoint",
		trigEngine = "pattern",
		snippetType = "snippet",
	},
	{
		t("breakpoint()"),
	}
)

ls.add_snippets("python",
	{
		dict_key_snip("it"),
		breakpoint,
	}
)
