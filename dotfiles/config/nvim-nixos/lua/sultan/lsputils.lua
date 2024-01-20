local lsputils = {}
lsputils.on_attach = function(_, bufnr)

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


    -- bufmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
lsputils.capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return lsputils
