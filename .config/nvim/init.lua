-- base --
vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.wrap = true
vim.o.scrolloff = 8

-- visual settings
vim.o.termguicolors = true -- ????
vim.o.colorcolumn = "100"
vim.o.signcolumn = "yes"
vim.o.cursorline = false
vim.o.showmatch = true
vim.o.cmdheight = 1

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
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

vim.keymap.set('n', '<leader>o', ':update <cr> :so <cr>')
vim.keymap.set('n', '<leader>w', ':write <cr>')
vim.keymap.set('n', '<leader>q', ':quit <cr>')

-- navigation
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append("_")

-- plugins --
vim.pack.add({
    -- UI
    { src = 'https://github.com/olimorris/onedarkpro.nvim' },
    { src = 'https://github.com/bluz71/vim-moonfly-colors' },
    -- editor
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- UI --
-- colorscheme 
require("moonfly").custom_colors({
    bg = "#000000",
})

vim.cmd("colorscheme moonfly")
vim.cmd("hi statusline guibg=NONE")

-- LSP --
vim.lsp.enable({
    'pyright',
    'lua_ls',
})


