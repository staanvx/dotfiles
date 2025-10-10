return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "cyberdream" },
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      -- vim.cmd.colorscheme("oxocarbon")

      local function set_black_bg()
        local bg = "#000000"
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = bg })
        hl(0, "NormalNC", { bg = bg })
        hl(0, "NormalFloat", { bg = bg })
        hl(0, "FloatBorder", { bg = bg })
        hl(0, "SignColumn", { bg = bg })
        hl(0, "FoldColumn", { bg = bg })
        hl(0, "LineNr", { bg = bg })
        hl(0, "CursorLine", { bg = bg })
        hl(0, "CursorLineNr", { bg = bg })
        hl(0, "StatusLine", { bg = bg })
        hl(0, "TabLineFill", { bg = bg })
        hl(0, "Pmenu", { bg = bg })
        hl(0, "PmenuSel", { bg = "#111111" }) -- можно тоже 000000
        -- популярные плагины
        hl(0, "TelescopeNormal", { bg = bg })
        hl(0, "TelescopeBorder", { bg = bg })
        hl(0, "WhichKeyFloat", { bg = bg })
        hl(0, "NeoTreeNormal", { bg = bg })
        hl(0, "NeoTreeNormalNC", { bg = bg })
      end

      set_black_bg()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "oxocarbon",
        callback = set_black_bg,
      })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      colors = { bg = "#000000" },

      overrides = function(colors)
        return {
          Normal = { bg = "#000000" },
          NormalNC = { bg = "#000000" },
          NormalFloat = { bg = "#000000" },
          FloatBorder = { bg = "#000000" },
          SignColumn = { bg = "#000000" },
          FoldColumn = { bg = "#000000" },
          LineNr = { bg = "#000000" },
          CursorLine = { bg = "#000000" },
          CursorLineNr = { bg = "#000000" },
          StatusLine = { bg = "#000000" },
          TabLineFill = { bg = "#000000" },
          Pmenu = { bg = "#000000" },
          PmenuSel = { bg = "#111111" },
          TelescopeNormal = { bg = "#000000" },
          TelescopeBorder = { bg = "#000000" },
          WhichKeyFloat = { bg = "#000000" },
          NeoTreeNormal = { bg = "#000000" },
          NeoTreeNormalNC = { bg = "#000000" },
        }
      end,
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)
      -- vim.cmd("colorscheme cyberdream")
      -- подстрахуемся от поздних перекрасов других плагинов
      vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
    end,
  },
}
