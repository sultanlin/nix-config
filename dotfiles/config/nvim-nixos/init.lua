local checkNixos = os.getenv("NEOVIM_NIXOS") or "false"
vim.loader.enable()
require("sultan.core.options")
require("sultan.core.keymaps")
require("sultan.core.autocmds")
require("sultan.core.launch")

-- spec("sultan.alpha")
-- spec("sultan.indentline")
-- spec("sultan.lualine")
spec("sultan.autopairs")
-- spec("sultan.auto-session")
spec("sultan.bufferline")
spec("sultan.colorscheme")
spec("sultan.comment")
spec("sultan.completion")
-- spec "sultan"   core
spec("sultan.gitsigns")
spec("sultan.hardtime")
-- spec("sultan.harpoon")
spec("sultan.icons")
spec("sultan.indentline")
-- spec "sultan"   languages
spec("sultan.languages.formatter")
spec("sultan.languages.linter")
spec("sultan.languages.servers")
-- spec("sultan.servers")
spec("sultan.lualine")
spec("sultan.pair-highlighting")
spec("sultan.telescope")
spec("sultan.treesitter")
spec("sultan.treesitter-text-objects")
spec("sultan.which-key")

if checkNixos == "false" then
	require("sultan.lazy")
end
