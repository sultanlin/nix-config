local M = {
	-- name = "ibl"
	-- "lukas-reineke/indent-blankline.nvim",
	-- event = "VeryLazy",
	-- commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
}

function M.config()
	local icons = require("sultan.icons")

	require("ibl").setup({
		-- char = icons.ui.LineLeft,
		-- char = icons.ui.LineMiddle,
		-- context_char = icons.ui.LineLeft,
		-- context_char = icons.ui.LineMiddle,
	})
end
return M
