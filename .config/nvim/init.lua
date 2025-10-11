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
vim.o.undofile = true

vim.keymap.set('n', '<leader>o', ':update <cr> :so <cr>')
vim.keymap.set('n', '<leader>w', ':write <cr>')
vim.keymap.set('n', '<leader>q', ':quit <cr>')

-- navigation
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append("_")

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- plugins --
vim.pack.add({
    -- UI
    { src = 'https://github.com/bluz71/vim-moonfly-colors' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    -- editor
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- navigation
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
})

-- UI --
-- colorscheme 
require("moonfly").custom_colors({
    bg = "#000000",
})

vim.cmd("colorscheme moonfly")
vim.cmd("hi statusline guibg=NONE")

-- editor --
-- LSP
vim.lsp.enable({
    'pyright',
    'lua_ls',
})

-- navigation --
-- oil
require("oil").setup()

--telescope

vim.keymap.set('n', '<leader>,', ':Telescope buffers <cr>', { desc = 'Buffer navigation like emacs' })

-- TODO buffer navigation with telescope (emacs-like)
