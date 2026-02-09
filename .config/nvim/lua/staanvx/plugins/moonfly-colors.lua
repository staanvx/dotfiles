require("moonfly").custom_colors({
  bg = "#000000",
})

vim.cmd("colorscheme moonfly")

vim.cmd("hi statusline guibg=NONE")
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = "#36c692" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE", fg = "#ff5189" })

-- moonfly (black)
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000", fg = "#36c692" })
vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "NONE", fg = "#ff5189" })
