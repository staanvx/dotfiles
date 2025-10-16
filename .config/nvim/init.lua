-- base --
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

local map = vim.keymap.set

map('n', '<leader>o', ':update <cr> :so <cr>')
map('n', '<leader>w', ':write <cr>')
map('n', '<leader>q', ':quit <cr>')


-- navigation
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append("_")

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- terminal
-- plugin/float-terminal
map("n", "<leader><cr>", "<CMD>Floaterm<CR>", { desc = "Open float terminal" })

map("t", "jk", "<c-\\><c-n>", { desc = "Escape from terminal-mode" })

-- split-terminal at the bottom
vim.keymap.set("n", "<leader>-", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- plugins --
vim.pack.add({
  -- UI
  { src = 'https://github.com/bluz71/vim-moonfly-colors' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  -- editor
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/Saghen/blink.cmp',                        tag = 'v1.7.0' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  -- navigation
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' }
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

require('nvim-web-devicons').setup()

-- editor --
-- lazydev
require('lazydev').setup()

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
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
    per_filetype = {
  --    sql = { 'dadbod' },
      lua = { inherit_defaults = true, 'lazydev' }
    },
    providers = {
   --   dadbod = { module = "vim_dadbod_completion.blink" },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
    prebuilt_binaries = { force_version = "v1.7.0" },
  }
})

require('nvim-autopairs').setup({ check_ts = true })

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

map('n', '<leader>lf', vim.lsp.buf.format, { desc = "Lsp format current buffer" })

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

map("n", "gl", vim.diagnostic.open_float, { desc = "Float diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

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

map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

--telescope
local function to_normal_mode()
  vim.cmd('stopinsert')
end

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<Esc>"] = require('telescope.actions').close,
        ["jk"]    = to_normal_mode,
      },
    }
  },
  pickers = {
    find_files = {
    },

    help_tags = {
      theme = "dropdown",
    },

    treesitter = {
      theme = "dropdown",
    },

    buffers = {
      theme = "ivy",
      sort_mru = true,
      ignore_current_buffer = true,
    },

    live_grep = {
      theme = "dropdown",
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

require('telescope').load_extension('fzf')

vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000", fg = "#36c692" })
vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "NONE", fg = "#ff5189" })

local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope previously open files' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope manpage entries' })
map('n', '<leader>tt', builtin.treesitter, { desc = 'Telescope with treesitter' })
map('n', '<leader>,', builtin.buffers, { desc = 'Telescope buffers' })

map('n', '<leader>fd', function()
  builtin.find_files {
    cwd = vim.fn.expand('~/.dotfiles/'),
    hidden = true,
    no_ignore = true,
  }
end, { desc = 'Telescope find config-files' })

-- fzf-lua
require('fzf-lua').setup({
  winopts = {
    height = 0.30,
    width  = 1.00,
    row    = 1.00,
    col    = 0.50,
    anchor = 'S',
    border = 'rounded',
  },

  fzf_opts = {
    ['--scheme'] = 'history',
    ['--style']  = 'minimal',
    ['--layout'] = 'default',
    ['--info']   = 'inline-right',
    ['--prompt'] = '>>> ',
  },
})

map('n', '<leader>f;', "<CMD>FzfLua commands<CR>", { desc = 'Fzf command list' })
map('n', '<leader>.', "<CMD>FzfLua tabs<CR>", { desc = 'Fzf command list' })

-- other --

-- TODO Telescope
--   TODO ui-select
-- TODO nvim-treesitter
-- TODO snippets
-- TODO tab navigation
-- TODO sql
