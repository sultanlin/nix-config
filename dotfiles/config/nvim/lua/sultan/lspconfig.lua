local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "folke/neodev.nvim",
        },
    },
}

M.config = function()
    local runtime_path = vim.split(package.path, ";")
    local omnipath = os.getenv("OMNISHARP_ROSLYN_PATH") .. "/lib/omnisharp-roslyn/OmniSharp.dll"
    local servers = {
        -- clangd = {},
        -- gopls = { cmd = { "gopls" }, { "go", "gomod", "gowork", "gotmpl", "tmpl", "templ" } },
        gopls = { cmd = { "gopls" } },
        templ = {},
        ruff_lsp = {},
        -- -- rust_analyser = {},
        lua_ls = {
            settings = {
                Lua = {
                    format = { enable = false },
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        special = {
                            spec = "require",
                        },
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim", "spec" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.api.nvim_get_runtime_file("", true) },
                    },
                    hint = {
                        enable = false,
                        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
                        await = true,
                        paramName = "Disable", -- "All" | "Literal" | "Disable"
                        paramType = true,
                        semicolon = "All", -- "All" | "SameLine" | "Disable"
                        setType = false,
                    },
                    telemetry = { enable = false },
                },
            },
        },
        omnisharp = {
            cmd = { "dotnet", omnipath },
            enable_roslyn_analyzers = true,
            -- enable_import_completion = true,   -- Can have negative impact on completion responsiveness
            organize_imports_on_format = false,
        },
        tsserver = {},
        html = {
            filetypes = { "html", "twig", "hbs" },
        },
        cssls = {},
        jsonls = {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            },
            setup = {
                commands = {
                    Format = {
                        function()
                            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                        end,
                    },
                },
            },
        },
        tailwindcss = {},
        eslint = {},
        -- svelte = {},
        -- graphql = {},
        -- prismals = {},
        emmet_ls = {},
        nil_ls = {},
        clangd = {},
        bashls = {},
        dockerls = {},
        -- nixd = {},
        -- htmx = { "html", "templ", "tmpl" },
    }

    local on_attach = function(client, bufnr)
        local bufmap = function(keys, func, descr)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true })
        end
        local toggle_inlay_hints = function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
        end
        bufmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eference")
        -- bufmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "[G]oto [R]eference")
        --
        -- bufmap('gd', vim.lsp.buf.definition)
        bufmap("gd", "<cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinition")
        bufmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        bufmap("gi", vim.lsp.buf.implementation, "[G]oto [i]mplementations")
        bufmap("gt", vim.lsp.buf.type_definition, "[G]oto [t]ype definitions")
        bufmap("gl", vim.diagnostic.open_float, "Open floating diagnostic message")

        -- bufmap('<leader>D', vim.lsp.buf.type_definition)
        bufmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        bufmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
        bufmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
        bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
        bufmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folder()))
        end, "[W]orkspace [L]ist folder")

        -- bufmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")

        bufmap(
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
            "[F]ormat"
        )
        bufmap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ction")
        bufmap("<leader>li", "<cmd>LspInfo<cr>", "[I]nfo")
        bufmap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic")
        bufmap("<leader>lh", "<cmd>lua require('sultan.lspconfig').toggle_inlay_hints()<cr>", "Toggle Inlay [H]ints")
        -- bufmap("<leader>lh", "<cmd>lua toggle_inlay_hints()<cr>", "Toggle Inlay [H]ints")
        bufmap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic")
        bufmap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", "Code[L]ens Action")
        bufmap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]ename")
        bufmap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", "[Q]uickfix / Open diagnostics list")

        vim.keymap.set(
            "v",
            "<leader>la",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            { buffer = bufnr, desc = "Code [A]ction", noremap = true, silent = true }
        )
        -- require("which-key").register({
        -- 	["<leader>la"] = {
        -- 		name = "LSP",
        -- 		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        -- 	},
        -- })

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
        end, { desc = "Format current buffer with LSP" })
        if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(bufnr, true)
        end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Testing
    local icons = require("sultan.icons")

    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
            },
        },
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        -- Old config
        -- virtual_text = {
        -- 	spacing = 4,
        -- 	source = "if_many",
        -- 	prefix = "●",
        -- 	-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- 	-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- 	-- prefix = "icons",
        -- },
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local lspconfig = require("lspconfig")
    -- Set up each server using the common configuration options
    for server, config in pairs(servers) do
        local server_config = vim.tbl_extend("force", {
            on_attach = on_attach,
            capabilities = capabilities,
        }, config)
        lspconfig[server].setup(server_config)
    end

    -- Lua LSP
    require("neodev").setup({ library = { plugins = { "neotest" }, types = true } })
end

M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

return M
