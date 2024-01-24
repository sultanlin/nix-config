local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {import = "sultan.plugins"}, 
  {import = "sultan.plugins.lsp"},
-- }, {
--     install = {
--       colorscheme = "carbonfox",
--     }
  ui = {
      -- A number <1 is a percentage, >1 is a fixed size.
      size = { width = 0.8, height = 0.8 },
      wrap = true,  -- `true`: Wrap the lines in the UI.  ( Looks a bit wonky without this. )

      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      -- TODO: Set the custom border here.
      border = "rounded",

      icons = {
          cmd         = " ",     -- TODO: Fix: ''     ( Can't see this )
          config      = " ",
          event       = " ",     -- TODO: Fix: ''     ( Can't see this )
          ft          = " ",
          init        = " ",
          import      = " ",
          keys        = " ",
          lazy        = "󰒲 ",
          loaded      = " ",
          not_loaded  = " ",
          plugin      = " ",
          runtime     = " ",
          source      = " ",
          start       = "🟆 ",     -- TODO: Fix: ''     ( Can't see this )
          task        = "✔ ",
          list = {
              "∈",
              "➜",
              "‒",
              "·",
          },
      },
  },
})
-- require("lazy").setup("pluginlist")

-- vim.keymap.set("n", "<leader>/l", "<cmd>:Lazy<cr>")
