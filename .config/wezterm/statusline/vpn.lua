local wezterm = require("wezterm")

local last_update_time = 0
local last_result = ""

local M = {}

function M.get(opts)
  opts = opts or {}
  local throttle = opts.throttle or 3

  local now = os.time()
  if now - last_update_time < throttle and last_result ~= "" then
    return last_result
  end

  local cmd = [[netstat -rn | grep -qE "utun[0-9].*0/1|128.0/1"]]
  local ok = os.execute(cmd .. " >/dev/null 2>&1")

  local text, color
  if ok == true or ok == 0 then
    text  = "󰒃 on "
    color = "#8cc85f"
  else
    text  = "󰒃 off"
    color = "#ff5d5d"
  end

  last_result = { text = text, color = color }
  last_update_time = now
  return last_result
end

return M
