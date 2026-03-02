local wezterm  = require 'wezterm'

local battery  = require 'statusline.battery'
local cpu      = require 'statusline.cpu'
local ram      = require 'statusline.ram'
local keyboard = require 'statusline.keyboard'
local music    = require 'statusline.music'
local vpn      = require 'statusline.vpn'

local M        = {}

function M.setup()
  wezterm.on('update-right-status', function(window, pane)
    local workspace = window:active_workspace() or "default"
    local date = wezterm.strftime '%H:%M '
    local batt = battery.get()
    local cpu_text = cpu.get({
      throttle = 5,
      icon = wezterm.nerdfonts.oct_cpu,
    })
    local ram_text = ram.get({
      throttle = 5,
      icon = wezterm.nerdfonts.cod_server,
    })
    local layout = keyboard.get({
      throttle = 5
    })
    local music_state = music.get({
      throttle = 5
    })
    local vpn_state = vpn.get({
      throttle = 3
    })

    window:set_left_status(wezterm.format {
      { Attribute = { Italic = false } },
      { Foreground = { Color = '#f7768e' } },
      { Background = { Color = '#1a1b26' } },
      { Text = ' ' .. '' },
      { Attribute = { Italic = false } },
      { Foreground = { Color = '#e0af68' } },
      { Background = { Color = '#1a1b26' } },
      { Text = ' ' .. workspace .. '' },
      { Attribute = { Italic = false } },
      { Foreground = { Color = '#73daca' } },
      { Background = { Color = '#1a1b26' } },
      { Text = ' ' .. '->' .. ' ' },
    })

  end)

  function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
      return title
    end
    return tab_info.active_pane.title
  end

  wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
      local title = tab_title(tab)

      local max_len = 20
      if #title > max_len then
        title = title:sub(1, max_len - 1) .. "…"
      end

      if tab.is_active then
        return {
          { Text = " " .. (tab.tab_index + 1) .. ":" .. " " .. title .. ' ' },
        }
      end

      if tab.is_last_active then
        return {
          { Text = " " .. (tab.tab_index + 1) .. ":" .. " " .. title .. ' ' },
        }
      end

      return {
        { Text = " " .. (tab.tab_index + 1) .. ":" .. " " .. title .. ' ' },
      }
    end
  )
end

return M
