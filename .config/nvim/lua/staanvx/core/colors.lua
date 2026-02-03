--transparrent
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparentThemeFix", { clear = true }),
  callback = function()
    vim.cmd [[
      hi Normal       guibg=NONE ctermbg=NONE
      hi NormalNC     guibg=NONE ctermbg=NONE
      hi NormalFloat  guibg=NONE ctermbg=NONE
      hi SignColumn   guibg=NONE ctermbg=NONE
      hi LineNr       guibg=NONE ctermbg=NONE
      hi EndOfBuffer  guibg=NONE ctermbg=NONE
    ]]
  end,
})
