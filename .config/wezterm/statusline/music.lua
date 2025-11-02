local wezterm          = require("wezterm")

local last_update_time = 0
local last_result      = ""

local RMPC             = "/opt/homebrew/bin/rmpc"
local JQ               = "/opt/homebrew/bin/jq"

local M                = {}

local function detect_state()
  local cmd = string.format([[%q status | %q -r '.state' | tr '[:upper:]' '[:lower:]']], RMPC, JQ)
  local ok, out = wezterm.run_child_process({ "bash", "-lc", cmd })
  if not ok or not out then
    return ""
  end
  return (out:gsub("%s+", "")):lower()
end

function M.get(opts)
  opts = opts or {}
  local throttle = opts.throttle or 5

  local now = os.time()
  if now - last_update_time < throttle and last_result ~= "" then
    return last_result
  end

  local state = detect_state()
  local text = ""
  if state:find("play") then
    text = " playing"
  elseif state:find("pause") then
    text = " paused "
  elseif state:find("stop") then
    text = " stopped"
  else
    text = ""
  end

  last_result = text
  last_update_time = now
  return text
end

return M
