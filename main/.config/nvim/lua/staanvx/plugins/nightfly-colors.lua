vim.cmd("colorscheme nightfly")

--vim.cmd("hi statusline guibg=NONE")
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#011627", fg = "#21c7a8" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE", fg = "#ff5874" })

-- nightfly
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#011627", fg = "#21c7a8" })
vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "NONE", fg = "#ff5874" })


