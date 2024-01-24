local M = {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}

M.config = function()
	require("hardtime").setup()
end

return M
