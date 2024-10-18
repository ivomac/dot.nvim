return {

	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		opts = {
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[p",
					jump_next = "]p",
					accept = "<CR>",
					refresh = "=p",
					open = "<C-h>"
				},
				layout = {
					position = "bottom",
					ratio = 0.32
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-j>",
					accept_word = false,
					accept_line = false,
					next = false,
					prev = false,
					dismiss = false,
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
				["."] = true,
			},
		},
		keys = {
			{ "=c", function() vim.cmd.Copilot("toggle") end, silent = true, desc = "Toggle Copilot" },
		},
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("luasnip").setup({
				load_ft_func =
					require("luasnip.extras.filetype_functions").extend_load_ft({
						markdown = { "json" },
						zsh = { "sh", "bash" },
						html = { "javascript" }
					})
			})

			require("luasnip").config.set_config({
				history = false,
				enable_autosnippets = true,
				update_events = { 'InsertEnter', 'InsertLeave' },
				region_check_events = { 'InsertEnter', 'InsertLeave' },
				delete_check_events = { 'InsertEnter', 'InsertLeave' },
			})
		end,
		keys = {
			{
				"<CR>",
				function()
					if require("luasnip").expandable() then
						require("luasnip").expand()
					else
						local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
						vim.api.nvim_feedkeys(key, "nt", false)
					end
				end,
				silent = true,
				mode = { "i", "s" },
				desc = "Expand Snippet",
			},
			{
				"<Tab>",
				function()
					if require("luasnip").jumpable() then
						require("luasnip").jump(1)
					elseif require("luasnip").expandable() then
						require("luasnip").expand()
					else
						local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
						vim.api.nvim_feedkeys(key, "nt", false)
					end
				end,
				silent = true,
				mode = { "i", "s" },
				desc = "Snippet Jump",
			},
			{
				"<S-Tab>",
				function()
					if require("luasnip").locally_jumpable() then
						require("luasnip").jump(-1)
					else
						local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
						vim.api.nvim_feedkeys(key, "nt", false)
					end
				end,
				silent = true,
				mode = { "i", "s" },
				desc = "Snippet Jump Back",
			},
			{
				"<C-l>",
				function()
					if require("luasnip").choice_active() then
						require("luasnip").change_choice(1)
					elseif require("copilot.suggestion").is_visible() then
						require("copilot.suggestion").accept_line()
					end
				end,
				silent = true,
				mode = { "i", "s" },
				desc = "Change Choice",
			},
		},
	},

	{
		"iurimateus/luasnip-latex-snippets.nvim",
		requires = { "L3MON4D3/LuaSnip" },
		opts = { use_treesitter = true }
	},

	{ "onsails/lspkind.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	{
		"hrsh7th/cmp-cmdline",
		dependencies = {
			"hrsh7th/cmp-buffer",
		},
	},
	{
		"petertriho/cmp-git",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"petertriho/cmp-git",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources(
					{
						{ name = "nvim_lsp" },
						{ name = "nvim_lsp_signature_help" },
						{ name = "luasnip",                option = { show_autosnippets = false } },
					},
					{
						{ name = "buffer" },
					}
				),
				view = {
					docs = {
						auto_open = true,
					},
				},
				formatting = {
					fields = { "kind", "abbr" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50, ellipsis_char = '…' })(
							entry,
							vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						return kind
					end,
				}
			})

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})
			require("cmp_git").setup()

			-- cmp.setup.cmdline('/', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = 'buffer' }
			-- 	}
			-- })

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{
						name = 'cmdline',
						option = {
							ignore_cmds = { 'Man', '!' }
						}
					}
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end,
		keys = {
			{
				"<C-f>",
				function()
					if not require("cmp").visible_docs() then
						require("cmp").open_docs()
					else
						require("cmp").scroll_docs(2)
					end
				end,
				silent = true,
				mode = { "i", "s", "c" },
				desc = "Scroll Docs Forward"
			},
			{
				"<C-s>",
				function()
					if not require("cmp").visible_docs() then
						require("cmp").open_docs()
					else
						require("cmp").scroll_docs(-2)
					end
				end,
				silent = true,
				mode = { "i", "s", "c" },
				desc = "Scroll Docs Backward"
			},
			{
				"<C-n>",
				function()
					require("cmp").select_next_item()
				end,
				silent = true,
				mode = { "i", "s", "c" },
				desc = "Next completion"
			},
			{
				"<C-p>",
				function()
					require("cmp").select_prev_item()
				end,
				silent = true,
				mode = { "i", "s", "c" },
				desc = "Previous completion"
			},
			{
				"<C-d>",
				function()
					if require("cmp").visible() then
						local entry = require("cmp").get_selected_entry()
						if entry ~= nil then
							local type = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
							if type ~= "Snippet" then
								require("cmp").confirm({ select = true })
							end
						end
					else
						local key = vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
						vim.api.nvim_feedkeys(key, "nt", false)
					end
				end,
				silent = true,
				mode = { "i", "s", "c" },
				desc = "Accept"
			},
		},
	},

	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		}
	},

}
