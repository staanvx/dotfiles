local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local statusline = require("statusline")

statusline.setup()

config.max_fps = 120

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 20.0

config.color_scheme = "moonfly"
config.colors = {
  background = 'black',
  tab_bar = {
    background = "#1a1b26",

    active_tab = {
      bg_color = '#000000',
      fg_color = '#ff5189',
      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = '#1a1b26',
      fg_color = '#9e9e9e',
    },

    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#9e9e9e',
      italic = true,
    },
  },
}

-- TODO frame
-- TODO рамка вокруг окна
-- TODO промпт для вкладки
-- TODO colors for tabs
-- TODO значок для активной вкладки

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 16

config.status_update_interval = 5000

return config
