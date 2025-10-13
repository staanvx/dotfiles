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
vim.opt.winborder = "single"

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

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

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
  { src = 'https://github.com/mason-org/mason.nvim' },
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
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = "#36c692" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE", fg = "#ff5189" })

-- editor --
-- blink.cmp (autocomplete)
require("blink.cmp").setup({
  keymap = {
    preset = 'enter',
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  },
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

-- Mason
require("mason").setup()

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

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Float diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- navigation --
-- oil
local detail = false

require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,

  columns = {
    "icon",
  },

  win_options = {
    wrap = false,
    signcolumn = "no",
    colorcolumn = "0",
  },

  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },

  keymaps = {
    ["<C-p>"] = "actions.preview",
    ["<leader>e"] = { "actions.close", mode = "n" },
    ["<C-c>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({ "icon" })
        end
      end,
    },

  },

  float = {
    padding = 2,
    max_width = 0.8,
    max_height = 0.8,
    border = "single",
    preview_split = "right",
  }
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

--telescope

vim.keymap.set('n', '<leader>fh', ':Telescope help_tags <cr>', { desc = 'Help search' })

local grp = vim.api.nvim_create_augroup("HelpToTab", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = grp,
  callback = function(args)
    if vim.bo[args.buf].buftype == "help" then
      vim.cmd("wincmd T")
    end
  end,
})

vim.keymap.set('n', '<leader>,', ':Telescope buffers <cr>', { desc = 'Buffer navigation like emacs' })

-- float-terminal
vim.keymap.set("n", "<leader>t", "<CMD>Floaterm<CR>", { desc = "Open float terminal" })


-- TODO buffer navigation with telescope (emacs-like)
-- TODO Telescope
-- TODO Mason setup
-- TODO nvim-treesitter
-- TODO snippets
