local wezterm = require('wezterm')

local last_update_time = 0
local last_result = ''

local M = {}

function M.get(opts)
  opts = opts or {}
  local throttle  = opts.throttle or 5
  local icon      = opts.icon or wezterm.nerdfonts.oct_cpu
  local use_pwsh  = opts.use_pwsh == false

  local now = os.time()
  if now - last_update_time < throttle and last_result ~= '' then
    return last_result
  end

  local success, result

  if string.match(wezterm.target_triple, 'windows') ~= nil then
    if use_pwsh then
      success, result = wezterm.run_child_process {
        'powershell.exe',
        '-Command',
        'Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage',
      }
    else
      success, result = wezterm.run_child_process {
        'cmd.exe', '/C', 'wmic cpu get loadpercentage'
      }
    end
  elseif string.match(wezterm.target_triple, 'linux') ~= nil then
    success, result = wezterm.run_child_process {
      'bash','-c',
      "LC_NUMERIC=C awk '/^cpu / {print ($2+$4)*100/($2+$4+$5)}' /proc/stat"
    }
  elseif string.match(wezterm.target_triple, 'darwin') ~= nil then
    success, result = wezterm.run_child_process {
      'bash','-c',
      "ps -A -o %cpu | LC_NUMERIC=C awk '{s+=$1} END {print s \"\"}'"
    }
  end

  if not success or not result then
    last_result = ''
    last_update_time = now
    return last_result
  end

  local cpu_val

  if string.match(wezterm.target_triple, 'windows') ~= nil then
    if use_pwsh then
      cpu_val = tonumber(result:match('%d+%.?%d*') or '0')
    else
      local m = result:match('(%d+)')
      cpu_val = tonumber(m or '0')
    end
  else
    cpu_val = tonumber((result:gsub('^%s*(.-)%s*$', '%1'))) or 0
  end

  if string.match(wezterm.target_triple, 'darwin') ~= nil then
    local ok, ncpu = wezterm.run_child_process { 'sysctl','-n','hw.ncpu' }
    if ok then
      local cores = tonumber(ncpu)
      if cores and cores > 0 then
        cpu_val = cpu_val / cores
      end
    end
  end

  local text = string.format('%s %.2f%%', icon, cpu_val)
  last_result = text
  last_update_time = now
  return text
end

return M
