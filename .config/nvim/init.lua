-- base --
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.scrolloff = 8
vim.o.swapfile = false

-- visual settings
vim.o.termguicolors = true -- ????
vim.o.colorcolumn = "100"
vim.o.signcolumn = "yes"
vim.o.cursorline = false
vim.o.showmatch = true
vim.o.cmdheight = 0
vim.o. = 0

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- keymaps (basic) --
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update <cr> :so <cr>')
vim.keymap.set('n', '<leader>w', ':write <cr>')
vim.keymap.set('n', '<leader>q', ':quit <cr>')

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








