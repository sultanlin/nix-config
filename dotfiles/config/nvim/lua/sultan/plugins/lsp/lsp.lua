return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },

    config = function()

        local servers = {
            clangd = {},
            gopls = {},
            pyright = {},
            rust_analyser = {},
            tsserver = {},
            html = { 
                filetypes = { 'html', 'twig', 'hbs' } 
            },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false},
                    telemetry = { enable = false },
                },
            },
            omnisharp = {
                filetypes = { "cs", "vb" },
                -- root_dir = require('lspconfig').util.root_pattern("*.csproj", "*.sln"),
                enable_roslyn_analyzers = true,
                analyze_open_documents_only = true,
                enable_import_completion = true,

            },
            tsserver = {},
            html = {},
            cssls = {},
            tailwindcss = {},
            svelte = {},
            graphql = {},
            prismals = {},
            emmet_ls = {},
        }


        local on_attach = function(_, bufnr)

        local bufmap = function(keys, func, descr)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true})
        end
            bufmap('<leader>rn', vim.lsp.buf.rename, "[R]e[n]ame")
            bufmap('<leader>ca', vim.lsp.buf.code_action, "See available [C]ode [A]ction")

        bufmap('gr', require('telescope.builtin').lsp_references, "[G]oto [R]eference")
        -- bufmap('gd', vim.lsp.buf.definition)
        bufmap('gd', "<cmd>Telescope lsp_definitions<CR>", "[G]oto [D]efinition")
        bufmap('gD', vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        bufmap('gi', vim.lsp.buf.implementation, "[G]oto [I]mplementations")
        bufmap('gt', vim.lsp.buf.type_definition, "[G]oto [T]ype definitions")


        -- bufmap('<leader>D', vim.lsp.buf.type_definition)
        bufmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, "[D]ocument [S]ymbols")
        bufmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        bufmap('K', vim.lsp.buf.hover, "Hover Documentation")
        bufmap('<C-k>', vim.lsp.buf.signature_help, "Signature Documentation")

        bufmap('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
        bufmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
        bufmap('<leader>wl', function() 
            print(vim.inspect(vim.lsp.buf.list_workspace_folder()))
        end, "[W]orkspace [L]ist folder")

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Lua LSP
        require('neodev').setup()

        local mason = require("mason")
        local mason_lspconfig = require "mason-lspconfig"
        local mason_tool_installer = require("mason-tool-installer")

        -- mason
        mason.setup({ 
            ensure_installed = servers,  
            automatic_installation = true,
            ui = {
                icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup{
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
        }
        
        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                    root_dir = (servers[server_name] or {}).root_dir,
                    cmd = (servers[server_name] or {}).cmd,
                    enable_editorconfig_support = (servers[server_name] or {}).enable_editorconfig_support,
                    enable_ms_build_load_projects_on_demand = (servers[server_name] or {}).enable_ms_build_load_projects_on_demand,
                    enable_roslyn_analyzers = (servers[server_name] or {}).enable_roslyn_analyzers,
                    analyze_open_documents_only = (servers[server_name] or {}).analyze_open_documents_only,
                    enable_import_completion = (servers[server_name] or {}).enable_import_completion,
                }
            end,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint", -- python linter
                "eslint_d", -- js linter
            },
        })
    end,
}
