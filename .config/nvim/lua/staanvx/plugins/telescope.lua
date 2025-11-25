local map = vim.keymap.set

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
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({
        previewer = false,
        initial_mode = 'normal',
      }),
    },
  }
})

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

-- moonfly (black)
--vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000", fg = "#36c692" })
--vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "NONE", fg = "#ff5189" })

-- nightfly
--vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#011627", fg = "#21c7a8" })
--vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "NONE", fg = "#ff5874" })

local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope previously open files' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope manpage entries' })
map('n', '<leader>tt', builtin.treesitter, { desc = 'Telescope with treesitter' })
map('n', '<leader>k', builtin.buffers, { desc = 'Telescope buffers' })

map('n', '<leader>fd', function()
  builtin.find_files {
    cwd = vim.fn.expand('~/.dotfiles/'),
    hidden = true,
    no_ignore = true,
  }
end, { desc = 'Telescope find config-files' })

map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

