-- REVIEW LATER: :h [
vim.loader.enable()
require("sultan.core.options")
require("sultan.core.keymaps")
require("sultan.core.autocmds")
require("sultan.core.launch")

spec("sultan.alpha")
spec("sultan.autopairs")
spec("sultan.autotag")
spec("sultan.barbecue")
-- spec("sultan.auto-session")
-- spec("sultan.bufferline")
spec("sultan.colorscheme")
spec("sultan.comment")
spec("sultan.completion")
spec("sultan.devicons")
-- spec("sultan.formatter")
spec("sultan.gitsigns")
spec("sultan.icons")
-- spec("sultan.illuminate")
spec("sultan.indentline")
-- spec("sultan.linter")
spec("sultan.lualine")
spec("sultan.lspconfig")
spec("sultan.navic")
spec("sultan.neogit")
spec("sultan.none-ls")
spec("sultan.nvimtree")
spec("sultan.project")
-- spec("sultan.pair-highlighting")
spec("sultan.telescope")
spec("sultan.toggleterm")
spec("sultan.treesitter")
spec("sultan.treesitter-text-objects")
spec("sultan.which-key")

-- Put them in extras
-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/extras/test.lua
-- https://www.youtube.com/watch?v=KGJV0n70Mxs
-- 4:54:00
-- https://github.com/mrjones2014/legendary.nvim
-- https://github.com/SmiteshP/nvim-navic
-- https://github.com/utilyre/barbecue.nvim
-- https://www.google.co.uk/search?q=total+typescript&sca_esv=600840769&source=hp&ei=zi-wZbXrI46gnesP__2B6A8&iflsig=ANes7DEAAAAAZbA93rukaY4B1cmKIs1kycl6B88CaMG5&ved=0ahUKEwi1iuiruvSDAxUOUGcHHf9-AP0Q4dUDCA8&uact=5&oq=total+typescript&gs_lp=Egdnd3Mtd2l6IhB0b3RhbCB0eXBlc2NyaXB0MgUQLhiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABEjjFlAAWMQVcAF4AJABAJgBywGgAdUTqgEGMC4xNi4xuAEDyAEA-AEBwgILEAAYgAQYigUYkQLCAgoQABiABBiKBRhDwgILEAAYgAQYsQMYgwHCAhEQLhiABBixAxiDARjHARjRA8ICDhAAGIAEGIoFGLEDGIMBwgILEC4YgAQYsQMYgwHCAggQABiABBixA8ICDhAuGIAEGLEDGMcBGNEDwgIOEC4YgAQYigUYsQMYgwHCAhEQLhiDARiRAhixAxiABBiKBcICFBAuGIAEGIoFGLEDGIMBGMcBGNEDwgIIEC4YgAQYsQPCAhEQLhiDARjHARixAxjRAxiABMICCxAuGIAEGMcBGNEDwgIHEC4YgAQYCg&sclient=gws-wiz
spec("sultan.extras.bqf")
spec("sultan.extras.colorizer")
spec("sultan.extras.dressing")
spec("sultan.extras.eyeliner")
spec("sultan.extras.fidget")
spec("sultan.extras.gitlinker")
spec("sultan.extras.harpoon")
spec("sultan.extras.matchup")
spec("sultan.extras.modicator")
-- spec("sultan.extras.neoscroll")
spec("sultan.extras.neotest")
-- spec("sultan.extras.noice")
spec("sultan.extras.oil")
spec("sultan.extras.spider")
spec("sultan.extras.surround")
spec("sultan.extras.tabby")
spec("sultan.extras.tabout")
spec("sultan.extras.todo-comments")
spec("sultan.extras.trouble")
-- spec("sultan.extras.auto-session")
spec("sultan.extras.ufo")
-- spec "sultan.extras.hardtime"     -- Keybind reminder here: https://github.com/m4xshen/hardtime.nvim

-- Inspired by chris@machine video/livestream:
-- https://www.youtube.com/watch?v=KGJV0n70Mxs
-- spec("sultan.servers"0
-- https://github.com/LunarVim/Launch.nvim
-- https://github.com/ChristianChiarulli/nvim

local checkNixos = os.getenv("NEOVIM_NIXOS") or "CHANGE THIS TO FALSE IF YOU ARE NOT USING NIXOS LINUX OS"
if checkNixos == "false" then
    spec("sultan.lazy.fugitive")
    spec("sultan.lazy.mason")
    spec("sultan.lazy.rainbow")
    spec("sultan.lazy.schemastore")
    spec("sultan.lazy.sleuth")
    require("sultan.lazy")
end
