local M = {}

function M.setup(config)
  config.window_decorations = "RESIZE"
  config.font_size = 22
  -- config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"
  config.macos_fullscreen_extend_behind_notch = true
end

return M
