require("catppuccin").setup({
  flavour = "auto",
  transparent_background = true,
  float = {
    transparent = true,
    solid = false,
  },
  highlight_overrides = {
    mocha = function(colors)
      return {
        StatusLine   = { bg = colors.mantle, fg = colors.text },
        StatusLineNC = { bg = colors.surface0, fg = colors.overlay0 },
      }
    end
  }
})

vim.cmd.colorscheme "catppuccin-mocha"
