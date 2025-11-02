local wezterm = require 'wezterm'

local M = {}

local CLR_5   = "#85dc85"
local CLR_4   = "#85dc85"
local CLR_3   = "#e3c78a"
local CLR_2   = "#ff5d5d"
local CLR_1   = "#ff5d5d"
local CLR_AC  = "#85dc85"
local CLR_CHG = "#85dc85"

local ICON_8   = " "
local ICON_7   = " "
local ICON_6   = " "
local ICON_5   = " "
local ICON_4   = " "
local ICON_3   = " "
local ICON_2   = " "
local ICON_1   = " "
local ICON_PLUG= " "
local ICON_CHG = " "

local function icon_for(pct)
  if pct >= 88 then return ICON_8
  elseif pct >= 75 then return ICON_7
  elseif pct >= 63 then return ICON_6
  elseif pct >= 50 then return ICON_5
  elseif pct >= 38 then return ICON_4
  elseif pct >= 25 then return ICON_3
  elseif pct >= 13 then return ICON_2
  else return ICON_1 end
end

local function color_for(pct)
  if pct >= 81 then return CLR_5
  elseif pct >= 61 then return CLR_4
  elseif pct >= 41 then return CLR_3
  elseif pct >= 21 then return CLR_2
  else return CLR_1 end
end

function M.get()
  local info = (wezterm.battery_info() or {})[1]
  if not info then
    return { text = "", color = nil }
  end

  local pct = math.floor((info.state_of_charge or 0) * 100 + 0.5)
  local state = tostring(info.state or ""):lower()

  local icon  = icon_for(pct)
  local color = color_for(pct)
  local prefix = ""

  if state:find("charging") then
    prefix = ICON_CHG
    color = CLR_CHG
  elseif state:find("ac") or state:find("plug") or state:find("full") or state:find("charged") then
    prefix = ICON_PLUG
    color = CLR_AC
  end

  return {
    text  = string.format("%s%s%d%%", prefix, icon, pct),
    color = color,
  }
end

return M
