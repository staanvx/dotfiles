vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.wrap = true
vim.o.scrolloff = 8

-- visual settings
vim.o.termguicolors = true
vim.o.colorcolumn = "110"
vim.o.signcolumn = "yes"
vim.o.cursorline = false
vim.o.showmatch = true
vim.o.cmdheight = 1
vim.opt.winborder = "single"

vim.o.wrap = false
vim.g.have_nerd_font = true

-- tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- file handling
vim.o.swapfile = false
vim.o.autoread = true

-- behaviour settings
vim.opt.clipboard:append("unnamedplus")
vim.o.hidden = true
vim.o.backspace = "indent,eol,start"
vim.o.mouse = "a"
vim.o.selection = "inclusive"
vim.o.encoding = "utf-8"
vim.o.undofile = true
vim.o.breakindent = true
vim.o.inccommand = 'split'

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.confirm = true

-- navigation
vim.cmd("set iskeyword+=-")
vim.cmd("set iskeyword+=_")
