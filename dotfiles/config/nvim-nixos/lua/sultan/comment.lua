local M = {}

M.config = function()
	local wk = require("which-key")
	wk.register({
		["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
	})

	wk.register({
		["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment", mode = "v" },
	})
	-- import comment plugin safely
	local comment = require("Comment")

	local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
	vim.g.skip_ts_context_commentstring_module = true
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	-- enable comment
	comment.setup({
		-- for commenting tsx and jsx files
		pre_hook = ts_context_commentstring.create_pre_hook(),
	})
end

return M
