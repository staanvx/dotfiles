local wezterm = require("wezterm")

local last_update_time = 0
local last_result = ""

local M = {}

function M.get(opts)
  opts = opts or {}
  local throttle = opts.throttle or 5

  local now = os.time()
  if now - last_update_time < throttle and last_result ~= "" then
    return last_result
  end

  local success, result = wezterm.run_child_process({
    "bash",
    "-c",
    [[defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -f 2 -d "=" | tr -d ' ;."']]
  })

  if not success or not result then
    last_result = ""
    last_update_time = now
    return last_result
  end

  local state = result:gsub("%s+", "")
  local text = ""

  if state == "ABC" then
    text = " en"
  elseif state == "Russian" then
    text = " ru"
  else
    text = ""
  end

  last_result = text
  last_update_time = now
  return text
end

return M
