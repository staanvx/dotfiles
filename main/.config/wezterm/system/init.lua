local wezterm = require("wezterm")

local M = {}
local impl

if wezterm.target_triple:find("darwin") then
  impl = require("system.macos")
elseif wezterm.target_triple:find("linux") then
  impl = require("system.linux")
else
  impl = {}
end

function M.setup(config)
  if impl.setup then impl.setup(config) end
end

return M
