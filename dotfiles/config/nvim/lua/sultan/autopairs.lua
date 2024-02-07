local M = {
    "windwp/nvim-autopairs",
}

M.config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
        map_char = {
            all = "(",
            tex = "{",
        },
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        disable_in_macro = false,
        enable_afterquote = true,
        map_bs = true,
        map_c_w = false,
        disable_in_visualblock = false,
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    })

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M

-- autopairs.setup({
-- 	check_ts = true, -- enable treesitter
-- 	ts_config = {
-- 		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
-- 		javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
-- 		java = false, -- don't check treesitter on java
-- 	},
-- 	disable_filetype = { "TelescopePrompt", "spectre_panel" },
-- })
