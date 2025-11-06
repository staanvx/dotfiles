local map = vim.keymap.set

map('n', '<leader>o', ':update <cr> :so <cr>')
map('n', '<leader>w', ':write <cr>')
map('n', '<leader>q', ':quit <cr>')

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- navigation

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- terminal
-- plugin/float-terminal
map("n", "<leader><cr>", "<CMD>Floaterm<CR>", { desc = "Open float terminal" })

map("t", "jk", "<c-\\><c-n>", { desc = "Escape from terminal-mode" })

-- split-terminal at the bottom
map("n", "<leader>-", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)
