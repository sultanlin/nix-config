local M = {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}

M.config = function()
	-- set keymaps
	local keymap = vim.keymap -- for conciseness

	local wk = require("which-key")
	wk.register({
		["<leader>h"] = {
			name = "harpoon",
		},
		-- 	["<leader>gj"] = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
		-- 	["<leader>gk"] = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
		-- 	["<leader>gp"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		-- 	["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		-- 	["<leader>gl"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		-- 	["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		-- 	["<leader>gs"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		-- 	["<leader>gu"] = {
		-- 		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		-- 		"Undo Stage Hunk",
		-- 	},
		-- 	["<leader>gd"] = {
		-- 		"<cmd>Gitsigns diffthis HEAD<cr>",
		-- 		"Git Diff",
		-- 	},
	})

	keymap.set(
		"n",
		"<leader>hm",
		"<cmd>lua require('harpoon.mark').add_file()<cr>",
		{ desc = "Mark file with harpoon" }
	)
	keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })
	keymap.set(
		"n",
		"<leader>hp",
		"<cmd>lua require('harpoon.ui').nav_prev()<cr>",
		{ desc = "Go to previous harpoon mark" }
	)
end

return M
