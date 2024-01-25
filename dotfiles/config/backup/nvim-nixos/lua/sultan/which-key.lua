local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    --   init = function()
    --     vim.o.timeout = true
    --     vim.o.timeoutlen = 500
    --   end,
}

function M.config()
    local mappings = {
        q = { "<cmd>confirm q<CR>", "Quit" },
        h = { "<cmd>nohlsearch<CR>", "NOHL" },
        [";"] = { "<cmd>tabnew | terminal<CR>", "[T]erminal" },
        v = { "<cmd>vsplit<CR>", "Split" },
        b = { name = "Buffers" },
        d = { name = "Debug" },
        f = { name = "Find" },
        g = { name = "Git" },
        l = { name = "LSP" },
        p = { name = "Plugins" },
        t = { name = "Test" },
        a = {
            name = "Tab",
            n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
            N = { "<cmd>tabnew %<cr>", "New Tab" },
            o = { "<cmd>tabonly<cr>", "Only" },
            h = { "<cmd>-tabmove<cr>", "Move Left" },
            l = { "<cmd>+tabmove<cr>", "Move Right" },
        },
        T = { name = "Treesitter" },
    }

    local which_key = require "which-key"
    which_key.setup {
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        window = {
            border = "rounded",
            position = "bottom",
            padding = { 2, 2, 2, 2 },
        },
        -- ignore_missing = true,
        -- show_help = false,
        -- show_keys = false,
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
    }

    which_key.register(mappings, opts)
end

return M

-- document existing key chains
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }