local M = {}

M.config = function()
	-- local nls = require("null-ls")
	-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	--
	-- nls.setup({
	-- 	sources = {
	-- 		nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
	-- 		nls.builtins.diagnostics.eslint_d,
	-- 		nls.builtins.formatting.prettier.with({
	-- 			extra_args = { "--single-quote", "false", "--html-whitespace-sensitivity", "css" },
	-- 		}),
	-- 		nls.builtins.formatting.prettierd.with({
	-- 			extra_args = { "--single-quote", "false", "--html-whitespace-sensitivity", "css" },
	-- 		}),
	-- 		nls.builtins.formatting.terraform_fmt,
	-- 		nls.builtins.formatting.black,
	-- 		-- nls.builtins.formatting.ruff_fix,
	-- 		nls.builtins.formatting.ruff,
	-- 		nls.builtins.formatting.ruff_format,
	-- 		nls.builtins.formatting.goimports,
	-- 		nls.builtins.formatting.gofmt,
	-- 		-- nls.builtins.formatting.gofumpt,
	-- 		nls.builtins.diagnostics.staticcheck,
	-- 		nls.builtins.formatting.latexindent.with({
	-- 			extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
	-- 		}),
	-- 		nls.builtins.code_actions.shellcheck,
	-- 		nls.builtins.code_actions.gitsigns,
	-- 		nls.builtins.formatting.shfmt,
	-- 		nls.builtins.diagnostics.ruff,
	-- 	},
	-- 	on_attach = function(client, bufnr)
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>tF",
	-- 			"<cmd>lua require('core.plugins.lsp.utils').toggle_autoformat()<cr>",
	-- 			{ desc = "Toggle format on save" }
	-- 		)
	-- 		if client.supports_method("textDocument/formatting") then
	-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 			vim.api.nvim_create_autocmd("BufWritePre", {
	-- 				group = augroup,
	-- 				buffer = bufnr,
	-- 				callback = function()
	-- 					if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
	-- 						vim.lsp.buf.format({ bufnr = bufnr })
	-- 					end
	-- 				end,
	-- 			})
	-- 		end
	-- 	end,
	-- })
	--
	-- local lint = require("lint")
	--
	-- lint.linters_by_ft = {
	-- 	linters_by_ft = {
	-- 		markdown = { "vale" },
	-- 		javascript = { "eslint_d" },
	-- 		typescript = { "eslint_d" },
	-- 		javascriptreact = { "eslint_d" },
	-- 		typescriptreact = { "eslint_d" },
	-- 		svelte = { "eslint_d" },
	-- 		python = { "ruff" },
	-- 	},
	-- }
	--
	-- -- https://www.youtube.com/watch?v=ybUE4D80XSk
	-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	-- 	group = lint_augroup,
	-- 	callback = function()
	-- 		lint.try_lint()
	-- 	end,
	-- })
	--
	-- vim.keymap.set("n", "<leader>l", function()
	-- 	lint.try_lint()
	-- end, { desc = "Trigger linting for current file" })
	--
	-- local conform = require("conform")
	-- conform.setup({
	-- 	format_on_save = {
	-- 		timeout_ms = 500,
	-- 		lsp_fallback = true,
	-- 	},
	-- 	formatters_by_ft = {
	-- 		lua = { "stylua" },
	-- 		--   -- Conform will run multiple formatters sequentially
	-- 		-- python = { "isort", "black" },
	-- 		python = { "ruff_fix ", "ruff_format" },
	-- 		-- Use a sub-list to run only the first available formatter
	-- 		javascript = { { "prettierd", "prettier" } },
	-- 		typescript = { { "prettierd", "prettier" } },
	-- 		typescriptreact = { { "prettierd", "prettier" } },
	-- 		javascriptreact = { { "prettierd", "prettier" } },
	-- 		svelte = { { "prettierd", "prettier" } },
	-- 		css = { { "prettierd", "prettier" } },
	-- 		html = { { "prettierd", "prettier" } },
	-- 		-- html = { "prettier" },
	-- 		json = { { "prettierd", "prettier" } },
	-- 		yaml = { { "prettierd", "prettier" } },
	-- 		markdown = { { "prettierd", "prettier" } },
	-- 		graphql = { { "prettierd", "prettier" } },
	--
	-- 		-- cs = { "csharpier" },
	-- 		-- html = { "prettier" },
	-- 		-- markdown = { "mdformat" },
	-- 		-- xml = { "xmlformat" },
	-- 		-- yaml = { "yamlfix" },
	-- 		go = { "goimports", "gofmt" },
	-- 		nix = { "alejandra" },
	-- 		-- rust = { "rustfmt" },
	-- 	},
	--
	-- 	-- Set format keybind
	-- 	vim.keymap.set({ "n", "v" }, "<leader>fm", function()
	-- 		conform.format({
	-- 			lsp_fallback = true,
	-- 			timeout_ms = 500,
	-- 		})
	-- 	end, { desc = "Format file or range (in visual mode)" }),
	-- })
end

return M
