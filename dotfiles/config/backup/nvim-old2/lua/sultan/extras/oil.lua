local M = {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
    require("oil").setup({
        float = {
            max_height = 20,
            max_width = 60,
        },
    })
    -- vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>o", "<CMD>Oil --float<CR>", { desc = "Oil" })
end

return M
