local wezterm = require('wezterm')

local last_update_time = 0
local last_result = ''

local M = {}

function M.get(opts)
  opts = opts or {}
  local throttle = opts.throttle or 5
  local icon     = opts.icon or wezterm.nerdfonts.cod_server
  local use_pwsh = opts.use_pwsh == false

  local now = os.time()
  if now - last_update_time < throttle and last_result ~= '' then
    return last_result
  end

  local success, result
  if string.match(wezterm.target_triple, 'windows') ~= nil then
    if use_pwsh then
      success, result = wezterm.run_child_process {
        'powershell.exe', '-Command',
        'Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory'
      }
    else
      success, result = wezterm.run_child_process {
        'cmd.exe','/C','wmic OS get FreePhysicalMemory'
      }
    end

  elseif string.match(wezterm.target_triple, 'linux') ~= nil then
    success, result = wezterm.run_child_process{
      'bash','-c','free -m | LC_NUMERIC=C awk \'NR==2{printf "%.2f", $3/1000 }\''}

  elseif string.match(wezterm.target_triple, 'darwin') ~= nil then
    success, result = wezterm.run_child_process { 'vm_stat' }
  end

  if not success or not result then
    last_result = ''
    last_update_time = now
    return last_result
  end

  local ram_text

  if string.match(wezterm.target_triple, 'linux') ~= nil then
    local used_gb = tonumber((result:gsub('^%s*(.-)%s*$', '%1'))) or 0
    ram_text = string.format('%.2f GB', used_gb)

  elseif string.match(wezterm.target_triple, 'darwin') ~= nil then
    local page_size = tonumber(result:match('page size of (%d+) bytes')) or 4096
    local anon      = tonumber(result:match('Anonymous pages:%s+(%d+).')) or 0
    local purgeable = tonumber(result:match('Pages purgeable:%s+(%d+).')) or 0
    local wired     = tonumber(result:match('Pages wired down:%s+(%d+).')) or 0
    local compressed= tonumber(result:match('Pages occupied by compressor:%s+(%d+).')) or 0

    local app_memory   = anon - purgeable
    if app_memory < 0 then app_memory = 0 end

    local used_bytes = (app_memory + wired + compressed) * page_size
    local used_gb = used_bytes / (1024*1024*1024)
    ram_text = string.format('%.2f GB', used_gb)

  else
    if use_pwsh then
      local kb = tonumber(result:match('%d+%.?%d*') or '0') or 0
      ram_text = string.format('%.2f GB', kb / 1024 / 1024)
    else
      local kb = tonumber(result:match('(%d+)') or '0') or 0
      ram_text = string.format('%.2f GB', kb / 1024 / 1024)
    end
  end

  last_result = string.format('%s %s', icon, ram_text)
  last_update_time = now
  return last_result
end

return M
