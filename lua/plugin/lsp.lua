local error = vim.diagnostic.severity.ERROR

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	signs = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		focusable = false,
		header = "",
		scope = "cursor",
	},
})

local server_capabilities = {
	ruff = {
		hoverProvider = false,
	},
	jedi_language_server = {
		referencesProvider = false,
		renameProvider = false,
	},
	pyright = {
		codeActionProvider = false,
		completionProvider = false,
		declarationProvider = false,
		definitionProvider = false,
		documentHighlightProvider = false,
		documentSymbolProvider = false,
		executeCommandProvider = false,
		hoverProvider = false,
		signatureHelpProvider = false,
		typeDefinitionProvider = false,
		workspaceSymbolProvider = false
	},
}

vim.api.nvim_create_user_command('LspCapabilities',
	function()
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			vim.print(vim.inspect(client.name))
			vim.print(vim.inspect(client.server_capabilities))
		end
	end,
	{}
)

function OpenDiagnosticIfNoFloat()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end
	vim.diagnostic.open_float()
end

local group = vim.api.nvim_create_augroup("LSP_DIAGNOSTICS", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	callback = OpenDiagnosticIfNoFloat,
	group = group,
})

local augroup = vim.api.nvim_create_augroup("LSP_ATTACH", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local capabilities = client.server_capabilities
		if capabilities.diagnosticProvider then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					local diagnostics = vim.diagnostic.get(0, { severity = error })
					if diagnostics and #diagnostics > 0 then
						return
					end
					vim.lsp.buf.format({ async = false })
				end
			})
		end

		if server_capabilities[client.name] then
			for capability, val in pairs(server_capabilities[client.name]) do
				client.server_capabilities[capability] = val
			end
		end

		if capabilities.codeActionProvider then
			vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { buffer = args.buf, desc = "LSP Action" })
		end
		if capabilities.definitionProvider then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "LSP Definition" })
		end
		if capabilities.typeDefinitionProvider then
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "LSP Type Def" })
		end
		if capabilities.implementationProvider then
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = args.buf, desc = "LSP Implementation" })
		end
		if capabilities.referencesProvider then
			vim.keymap.set({ "n", "x" }, "grr", vim.lsp.buf.references, { buffer = args.buf, desc = "LSP References" })
		end
		if capabilities.renameProvider then
			vim.keymap.set({ "n",  "x" }, "grn", vim.lsp.buf.rename, { buffer = args.buf, desc = "LSP Rename" })
		end
		if capabilities.documentFormattingProvider then
			vim.keymap.set("n", "gqq", vim.lsp.buf.format, { buffer = args.buf, desc = "LSP Format" })
		end
	end,
})

local fts = {
	"python", "vim", "julia",
	"c", "cpp", "cuda", "zig", "zir",
	"objc", "objcpp", "proto", "rust",
	"go", "gomod", "gowork", "gotmpl",
	"sh", "bash", "zsh",
	"css", "html", "templ", "typescript",
	"jq", "json", "lua", "yaml", "sql", "mysql",
	"typst", "markdown", "bib", "tex",
	"plaintex", "matlab",
}

return {

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"kevinhwang91/nvim-ufo",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		ft = fts,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			capabilities.textDocument.completion = cmp_capabilities.textDocument.completion
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

			local servers = { "clangd", "gopls", "html", "julials", "lua_ls",
				"marksman", "matlab_ls", "sqls", "ts_ls",
				"pyright", "jedi_language_server", "ruff",
				"vimls", "yamlls", "zls", 
			}
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end

			lspconfig.bashls.setup({
				filetypes = { "sh", "bash", "zsh", "csh" },
			})

			lspconfig.jsonls.setup({
				init_options = {
					provideFormatter = false,
				}
			})

			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						}
					}
				}
			})

			local texlab_config = {
				settings = {
					texlab = {
						auxDirectory = ".",
						bibtexFormatter = "texlab",
						build = {
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							executable = "latexmk",
							forwardSearchAfter = false,
							onSave = true
						},
						chktex = {
							onEdit = false,
							onOpenAndSave = true,
						},
						diagnosticsDelay = 1000,
						formatterLineLength = 80,
						latexFormatter = "latexindent",
						latexindent = {
							modifyLineBreaks = false
						}
					}
				}
			}
			lspconfig.texlab.setup(texlab_config)
			require("ufo").setup()
		end,
		keys = {
			{ "gqd", function() vim.diagnostic.setqflist() end, desc = "Fill QFix with Diag" },
			{ "=i", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints" },
		},
	},

}
