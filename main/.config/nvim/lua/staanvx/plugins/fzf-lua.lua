local map = vim.keymap.set

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
