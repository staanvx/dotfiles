local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local statusline = require("statusline")

statusline.setup()

config.enable_kitty_keyboard = false
config.max_fps = 120

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 22.0

config.color_scheme = 'default'
config.colors = {
  background = 'black',

  tab_bar = {
    background = "#1a1b26",

    active_tab = {
      bg_color = '#1a1b26',
      fg_color = '#7dcfff',
    },

    inactive_tab = {
      bg_color = '#1a1b26',
      fg_color = '#a9b1d6',
    },

    inactive_tab_hover = {
      bg_color = '#7dcfff',
      fg_color = 'black',
      italic = true,
    },
  },
}

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"
--config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"


config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 20
config.native_macos_fullscreen_mode = false
--config.status_update_interval = 5000
config.audible_bell = "Disabled"

config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}


config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}

config.keys = {
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

wezterm.on("window-resized", function(window, _)
  local overrides = window:get_config_overrides() or {}

  if window:get_dimensions().is_full_screen then
    overrides.window_background_opacity = 1.0
  else
    overrides.window_background_opacity = 0.85
  end

  window:set_config_overrides(overrides)
end)


return config
