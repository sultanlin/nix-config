-- REVIEW LATER: :h [
vim.loader.enable()
require "sultan.core.options"
require "sultan.core.keymaps"
require "sultan.core.autocmds"
require "sultan.core.launch"

-- spec("sultan.alpha")
spec "sultan.autopairs"
spec "sultan.barbecue"
-- spec("sultan.auto-session")
-- spec("sultan.bufferline")
spec "sultan.colorscheme"
spec "sultan.comment"
spec "sultan.completion"
spec "sultan.eyeliner"
spec "sultan.gitsigns"
-- spec "sultan.hardtime"     -- Keybind reminder here: https://github.com/m4xshen/hardtime.nvim
spec "sultan.harpoon"
spec "sultan.icons"
-- spec "sultan.illuminate"
spec "sultan.indentline"
spec "sultan.lualine"
spec "sultan.lspconfig"
spec "sultan.navic"
spec "sultan.neoscroll"
spec "sultan.neotest"
spec "sultan.none-ls"
spec "sultan.nvimtree"
-- spec("sultan.pair-highlighting")
spec "sultan.oil"
spec "sultan.schemastore"
spec "sultan.sleuth"
spec "sultan.tabby"
spec "sultan.tabout"
spec "sultan.telescope"
spec "sultan.treesitter"
spec "sultan.treesitter-text-objects"
spec "sultan.ufo"
spec "sultan.which-key"

-- Inspired by chris@machine video/livestream:
-- https://www.youtube.com/watch?v=KGJV0n70Mxs
-- spec("sultan.servers"0
-- https://github.com/LunarVim/Launch.nvim
-- https://github.com/ChristianChiarulli/nvim

local checkNixos = os.getenv "NEOVIM_NIXOS" or "CHANGE THIS TO FALSE IF YOU ARE NOT USING NIXOS LINUX OS"
if checkNixos == "false" then
    require "sultan.lazy"
end
