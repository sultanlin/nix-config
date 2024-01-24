local M = {
	"catppuccin/nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function()
	-- vim.cmd("colorscheme gruvbox")
	-- vim.cmd("colorscheme gruvbox-material")
	-- vim.cmd("colorscheme PaperColor")
	vim.cmd("colorscheme catppuccin")
end

return M
