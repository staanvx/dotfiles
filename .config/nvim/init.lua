-- base --
vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.wrap = true
vim.o.scrolloff = 8

-- visual settings
vim.o.termguicolors = true -- ????
vim.o.colorcolumn = "110"
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
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/Saghen/blink.cmp',               tag = 'v1.7.0' },
    -- navigation
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
-- blink.cmp (autocomplete)
require("blink.cmp").setup({
    keymap = { preset = 'default' },

    appearance = {
        nerd_font_variant = 'mono',
    },

    completion = {
        documentation = { auto_show = true },
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = { force_version = "v1.7.0" },
    }
})

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- LSP
vim.lsp.enable({
    'pyright',
    'lua_ls',
})

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = { diagnostics = { globals = { 'vim' } } },
    },
})

vim.lsp.config('pyright', {
    capabilities = capabilities,
})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Diagnostics (float)" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })

-- navigation --
-- oil
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

require("oil").setup({
    default_file_explorer = true,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
        "permissions",
        "icon",
        "size",
        "mtime",
    },
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        colorcolumn = "0",
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
        winbar = "%!v:lua.get_oil_winbar()",
    },
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
            return false
        end,
        -- Sort file names with numbers in a more intuitive order for humans.
        -- Can be "fast", true, or false. "fast" will turn it off for large directories.
        natural_order = "fast",
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
        },
    },
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--telescope

vim.keymap.set('n', '<leader>,', ':Telescope buffers <cr>', { desc = 'Buffer navigation like emacs' })

-- TODO buffer navigation with telescope (emacs-like)
