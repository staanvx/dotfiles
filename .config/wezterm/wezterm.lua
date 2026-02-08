local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local statusline = require("statusline")
require("system").setup(config)
statusline.setup()

config.enable_kitty_keyboard = false
config.max_fps = 120

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 22.0

config.color_scheme = 'default'
config.colors = {
  background = 'black',

  tab_bar = {
--    background = "#1a1b26",
    background = "black",

    active_tab = {
      bg_color = 'black',
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


config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 20
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

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' },
  },
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
}
-- wezterm.on("window-resized", function(window, _)
--   local overrides = window:get_config_overrides() or {}
-- 
--   if window:get_dimensions().is_full_screen then
--     overrides.window_background_opacity = 1.0
--   else
--     overrides.window_background_opacity = 0.85
--   end
-- 
--   window:set_config_overrides(overrides)
-- end)


return config


