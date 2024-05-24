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


local calculate_comment_string = require('Comment.ft').calculate
local utils = require('Comment.utils')

local get_cstring = function()
	local cstring = calculate_comment_string({ ctype = 1, range = utils.get_region() }) or vim.bo.commentstring
	local left, right = utils.unwrap_cstr(cstring)
	return { left, right }
end

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
				local char = vim.api.nvim_get_current_line():sub(colnr+1, colnr+1)
				if char == Pair[2] then
					return {
						clear_region = { from = {linenr, colnr-1}, to = {linenr, colnr+1} },
					}
				end
			end
		},
		fmt(res, { i(1, nil) })
	)
end

local todo = s(
	{
		trig = "todo",
		name = "TODO",
		desc = "TODO comment",
		snippetType = "snippet",
	},
	fmt(
		'{} TODO(ivo): {} {}',
		{
			f(function() return get_cstring()[1] end),
			i(1, nil),
			f(function() return get_cstring()[2] end)
		}
	)
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
		bang,
		env,
	}
)

ls.add_snippets("tex",
	{
		make_pair_snip("$$"),
	}
)

local function dict_snip(value)
	return s(
		{
			trig = value,
			name = "dictionary",
			desc = "create a python dictionary",
			hidden = true,
			snippetType = "snippet",
		},
		fmt([[
				{{
					{}: {},{}
				}}
			]],
			{
				i(1, ""),
				i(2, ""),
				i(3, nil),
			}
		)
	)
end

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

local auto_dict_key = s(
	{
		trig = "%s+.+:%s+.+,",
		name = "auto dictionary item",
		desc = "start a key:value in next line automatically",
		trigEngine = "pattern",
		hidden = true,
		wordTrig = false,
		snippetType = "snippet",
		resolveExpandParams = function()
			return {
				clear_region = { from = {0, 0}, to = {0, 0} },
			}
		end
	},
	fmt([[{}
{}: {},{}
]],
		{
			t(nil),
			i(1, ""),
			i(2, ""),
			i(3, nil),
		}
	)
)

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
		-- dict_snip("{"),
		dict_key_snip("it"),
		-- auto_dict_key,
		breakpoint,
	}
)
