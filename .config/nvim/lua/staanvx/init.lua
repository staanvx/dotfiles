--core
require("staanvx.core.options")
require("staanvx.core.keymaps")
--require("staanvx.core.colors") -- transparrent
require("staanvx.core.commands")


--plugins
vim.pack.add({
  -- UI
  { src = 'https://github.com/bluz71/vim-moonfly-colors' },
  { src = 'https://github.com/bluz71/vim-nightfly-colors' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  -- editor
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/Saghen/blink.cmp',                        tag = 'v1.7.0' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/catgoose/nvim-colorizer.lua' },
  -- navigation
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/chomosuke/typst-preview.nvim' }
})


require("staanvx.plugins.moonfly-colors")
--require("staanvx.plugins.nightfly-colors")
--require("staanvx.plugins.ayu-colors")
--require("staanvx.plugins.catppuccin")
--require("staanvx.plugins.tokyonight")

require("staanvx.plugins.web-devicons")
require("staanvx.plugins.autopairs")
require("staanvx.plugins.lazydev")
require("staanvx.plugins.blink-cmp")
require("staanvx.plugins.mason")
require("staanvx.plugins.typst-preview")
require("staanvx.plugins.treesitter")
require("staanvx.plugins.oil")
require("staanvx.plugins.telescope")
require("staanvx.plugins.fzf-lua")
require("staanvx.plugins.which-key")
require("staanvx.plugins.colorizer")
require("staanvx.plugins.lualine")
require("staanvx.plugins.smear-cursor")
