local servers = {
	"lua_ls",
	"nil_ls",
	"rust_analyzer",
	"pyright",
}

local lsp_keymaps = {
	-- { mode(s), key, action, description }
	{ "n", "gd", vim.lsp.buf.definition, "Go to definition" },
	{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
	{ "n", "gi", vim.lsp.buf.implementation, "Go to implementation" },
	{ "n", "gr", vim.lsp.buf.references, "List references" },
	{ "n", "K", vim.lsp.buf.hover, "Hover docs" },
	{ "n", "<C-k>", vim.lsp.buf.signature_help, "Signature help" },
	{ "n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol" },
	{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action" },
	{ "n", "gl", vim.diagnostic.open_float, "Line diagnostics" },
	{ "n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic" },
	{ "n", "]d", vim.diagnostic.goto_next, "Next diagnostic" },
	{
		"n",
		"<leader>f",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format buffer",
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(_, bufnr)
			for _, map in ipairs(lsp_keymaps) do
				local mode, lhs, rhs, desc = map[1], map[2], map[3], map[4]
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end
		end

		for _, name in ipairs(servers) do
			local opts = { on_attach = on_attach, capabilities = capabilities }
			if name == "lua_ls" then
				opts.settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } }, -- <- replaces .luarc.json/.luacheckrc
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				}
			end
			lspconfig[name].setup(opts)
		end
	end,
}
