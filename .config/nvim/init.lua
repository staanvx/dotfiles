-- base --
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true

vim.o.swapfile = false

vim.o.termguicolors = true -- ????

-- tabulation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- keymaps (basic) --
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>w', ':write <cr>')
vim.keymap.set('n', '<leader>q', ':quit <cr>')

-- plugins --
vim.pack.add({
    { src = 'https://github.com/olimorris/onedarkpro.nvim' },
    { src = 'https://github.com/bluz71/vim-moonfly-colors' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

--colorscheme --
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
