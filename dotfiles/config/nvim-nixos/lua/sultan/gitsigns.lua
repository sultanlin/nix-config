local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	cmd = "Gitsigns",
}

M.config = function()
	local icons = require("sultan.icons")

	local wk = require("which-key")
	-- wk.register({
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
	-- })
	require("gitsigns").setup({

		-- See `:help gitsigns.txt`
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			vim.keymap.set(
				"n",
				"<leader>hp",
				require("gitsigns").preview_hunk,
				{ buffer = bufnr, desc = "Preview git hunk" }
			)

			-- don't override the built-in and fugitive keymaps
			local gs = package.loaded.gitsigns
			vim.keymap.set({ "n", "v" }, "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
			vim.keymap.set({ "n", "v" }, "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
		end,
	})
end

return M
