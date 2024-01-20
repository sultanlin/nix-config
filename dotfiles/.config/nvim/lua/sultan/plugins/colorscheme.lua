return {
  -- color schemes
  {
    --- main color scheme
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,      -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.cmd("colorscheme tokyonight-night")
      -- vim.cmd("colorscheme tokyonight")
      -- vim.cmd("colorscheme gruvbox")
      vim.cmd("colorscheme bamboo")

    end
  },

  -- Cool color schemes to try out
  { "catppuccin/nvim",          name = "catppuccin", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "folke/tokyonight.nvim",    event = "VeryLazy" },
  -- { "sonph/onehalf/vim",    event = "VeryLazy" },
  { "ellisonleao/gruvbox.nvim", event = "VeryLazy" },
  { "rebelot/kanagawa.nvim",    event = "VeryLazy" },
  { "navarasu/onedark.nvim",    event = "VeryLazy" },
  { "shaunsingh/nord.nvim",    event = "VeryLazy" },
  { "ayu-theme/ayu-vim",    event = "VeryLazy" },
  { "cocopon/iceberg.vim",    event = "VeryLazy" },
  { "bluz71/vim-nightfly-guicolors",    event = "VeryLazy" },
  { "sainnhe/sonokai",    event = "VeryLazy" },
  { "sainnhe/everforest",    event = "VeryLazy" },
  { "sainnhe/gruvbox-material",    event = "VeryLazy" },
  { "ribru17/bamboo.nvim",    event = "VeryLazy" },



  -- -- Syntastics
  -- vim.api.nvim_set_hl(0, 'ALEErrorSign', { fg="#FF5555" }),
  -- vim.api.nvim_set_hl(0, 'ALEErrorLine', { bg="#331111" }),
  -- vim.api.nvim_set_hl(0, 'ALEVirtualTextError', { fg="#777777", bg="#331111" }),
  -- vim.api.nvim_set_hl(0, 'ALEWarningSign', { fg="#FFFF55" }),
  -- vim.api.nvim_set_hl(0, 'ALEWarningLine', { bg="#2A2A11" }),
  -- vim.api.nvim_set_hl(0, 'ALEVirtualTextWarning', { fg="#777777", bg="#2A2A11" }),
  -- vim.api.nvim_set_hl(0, 'ALEStyleErrorSign', { fg="#FF5555" }),
  -- vim.api.nvim_set_hl(0, 'ALEStyleErrorLine', { bg="#331111" }),
  -- vim.api.nvim_set_hl(0, 'ALEVirtualTextStyleError', { fg="#777777", bg="#331111" }),
  -- vim.api.nvim_set_hl(0, 'ALEStyleWarningSign', { fg="#6666CC" }),
  -- vim.api.nvim_set_hl(0, 'ALEStyleWarningLine', { bg="#2A2A11" }),
  -- vim.api.nvim_set_hl(0, 'ALEVirtualTextStyleWarning', { fg="#777777", bg="#2A2A11" }),
  --
  -- -- Dap,
  -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg='#AAAAFF' }),
  -- vim.api.nvim_set_hl(0, 'DapBreakpointLine', { bg='#222244' }),
  -- vim.api.nvim_set_hl(0, 'DapStopped', { fg='#228822' }),
  -- vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg='#224422' }),
  --
  -- vim.cmd[[ :command! MdView ! litemdview -t 2 %:p & disown ]],
  --
  -- -- vim.api.nvim_set_hl(0, 'Normal', { fg='#CCCCCC' }),
}
