-- ########################
-- #   Neovim Options    #
-- #######################
local tablength = 4
local options = {
	-- tabbing
	smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
	expandtab = true, -- convert tabs to spaces
	softtabstop = tablength, --- Insert 2 spaces for a tab
	tabstop = tablength, -- number of spaces when you tab
	shiftwidth = tablength, -- indent when using >> or <<
	showtabline = 2, --- Always show tabs

	hidden = true, -- required to keep multiple buffers and open multiple buffers
	number = true, -- show numbers on the left
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width {default 4}
	mouse = "a", -- allow mouse to be used
	ignorecase = true, -- ignore case when searching
	smartcase = true, -- smart case idk
	hlsearch = false, -- highlight search
	smartindent = true, -- make indenting smarter again
	wrap = true, -- new line when characters go out of screen
	breakindent = true, -- keep indentation after wrap
	showbreak = "  ", -- characters that appear before wrapped new line
	--let &showbreak = '↳ '
	cpo = "n",
	shiftround = true, -- Round indent
	pumheight = 10, -- pop up menu height
	pumblend = 10, -- transparency of pop-up menu
	splitbelow = true, -- force all horizontal splits to go below current window
	splitkeep = "screen",
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 200, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	cursorline = true, -- highlight the current line
	signcolumn = "yes:2", -- always show the sign column, otherwise it would shift the text each time
	scrolloff = 8, -- minimal number of columns to scroll horizontally.
	sidescrolloff = 8, -- minimal number of screen columns
	lazyredraw = false, -- Won't be redrawn while executing macros, register and other commands.
	termguicolors = true, -- Enables 24-bit RGB color in the TUI
	fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }, -- make EndOfBuffer invisible
	ruler = false,
	autowrite = true, -- Automatically write/auto save
	confirm = true, -- Confirm to save changes before exiting modified buffer
	sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }, -- buffers to save
	virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
	wildmode = "longest:full,full", -- Command-line completion mode
	winminwidth = 5, -- Minimum window width
	completeopt = "menu,menuone,noselect", -- Better autocompletion
	clipboard = "unnamedplus", --- Copy-paste between vim and everything else
	cmdheight = 0, --- Give more space for displaying messages
	foldcolumn = "0",
	foldnestmax = 0,
	foldlevel = 99, --- Using ufo provider need a large value
	foldlevelstart = 99, --- Expand all folds by default
	laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
	viminfo = "'1000", --- Increase the size of file history

	-- Neovim defaults
	autoindent = true, --- Good auto indent
	backspace = "indent,eol,start", --- Making sure backspace works
	backup = false, --- Recommended by coc
	--- Concealed text is completely hidden unless it has a custom replacement character defined (needed for dynamically showing tailwind classes)
	conceallevel = 2,
	concealcursor = "", --- Set to an empty string to expand tailwind class when on cursorline
	encoding = "utf-8", --- The encoding displayed
	errorbells = false, --- Disables sound effect for errors
	fileencoding = "utf-8", --- The encoding written to file
	incsearch = true, --- Start searching before pressing enter
	showmode = false, --- Don't show things like -- INSERT -- anymore
	--- unknown options
	formatoptions = "jcroqlnt", --- tcqj  for autoformat
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
}

local global = {
	mkdp_auto_close = false, -- Don't Exit Preview When Switching Buffers
	autoformat = true, -- Automatically format
	mapleader = " ", -- Set mapleader to space
	maplocalleader = " ",
	startup_message = false,
	speeddating_no_mappings = 1, --- Disable default mappings for speeddating
}

--vim.opt.shortmess:append "Ac" -- Disable asking when editing file with swapfile.
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

for name, value in pairs(options) do
	vim.opt[name] = value
end

for name, value in pairs(global) do
	vim.g[name] = value
end

-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m"
-- opt.grepprg = "rg --vimgrep"
--
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,i:blinkon100,i:block"
