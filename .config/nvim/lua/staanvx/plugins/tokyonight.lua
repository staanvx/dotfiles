require("tokyonight").setup({
  transparent = true,
  style = "night",
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
})

vim.cmd.colorscheme "tokyonight"
