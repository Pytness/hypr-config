local constants = require 'constants'
local utils = require 'utils'
local logger = utils.Logger:new(os.getenv 'HOME' .. '/.config/hypr/hyprland.log')
logger:set_level(4)

SRC_PATH = os.getenv 'HOME' .. '/.local/share/bin'
local MAIN_MOD = 'SUPER'

local function k(keys)
  local s = ''
  for _, v in ipairs(keys) do
    s = s .. v .. ' + '
  end
  return s:sub(1, -4)
end

local function bind(keys, cmd, opt)
  hl.bind(k(keys), cmd, opt)
end

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

function dontkillsteam()
  local active_window = hl.get_active_window()
  if active_window then
    if active_window.class == 'Steam' then
    -- TODO: unmap window
    else
      hl.dispatch(hl.dsp.window.close())
    end
  end
end

local __last_editinnvim_execution = nil

local function edit_in_nvim()
  -- BUG: apparently using send_shortcut will make the keybind execute twice
  -- FOR SOME FUCKING REASON
  if __last_editinnvim_execution ~= nil and os.time() - __last_editinnvim_execution < 1 then
    logger:log 'edit_in_nvim executed too recently, skipping'
    return
  else
    __last_editinnvim_execution = os.time()
  end

  local TAG = 'editinnvim'
  local tempfile = os.tmpname()

  local active_window = hl.get_active_window()

  if active_window == nil then
    return
  end

  hl.dispatch(hl.dsp.send_shortcut { mods = 'CTRL', key = 'a', { adress = active_window.address } })
  hl.dispatch(hl.dsp.send_shortcut { mods = 'CTRL', key = 'c', { adress = active_window.address } })

  -- sleep is needed to ensure wl-paste gets the updated clipboard content
  os.execute 'sleep 0.1'
  hl.exec_cmd('wl-paste > ' .. tempfile)

  local open_handler
  open_handler = hl.on('window.open', function(w, b)
    --- @type HL.Window
    local window = w

    local tags = window.tags
    local target_address = nil
    logger:log(
      'Window opened with title '
        .. w.title
        .. ' and class '
        .. w.class
        .. ' and tags '
        .. (type(tags) == 'table' and table.concat(tags, ',') or tostring(tags))
    )

    if utils.match_tag(TAG, tags) then
      target_address = window.address
    end

    if target_address ~= nil then
      logger:log('Opened window with address ' .. target_address .. ' for editing in nvim')

      local close_handler
      close_handler = hl.on('window.close', function(w, b)
        if w.address ~= target_address then
          return
        end

        logger:log('Closed window with address ' .. target_address .. ', copying content back to clipboard and cleaning up')

        hl.exec_cmd('cat ' .. tempfile .. ' | wl-copy -n && rm ' .. tempfile)

        hl.timer(function()
          hl.dispatch(hl.dsp.send_shortcut { mods = 'CTRL', key = 'v', { adress = active_window.address } })
          open_handler:remove()
          close_handler:remove()

          __last_editinnvim_execution = nil
        end, { timeout = 100, type = 'oneshot' }):set_enabled(true)
      end)
    end
  end)

  local nvim_cmd = 'st -e nvim ' .. tempfile
  hl.exec_cmd(nvim_cmd, {
    float = true,
    center = true,
    tag = 'editinnvim',
  })
end

-- Window / Session actions
bind({ MAIN_MOD, 'q' }, dontkillsteam)
bind({ 'ALT', 'F4' }, hl.dsp.window.kill())
bind({ MAIN_MOD, 'Delete' }, hl.dsp.exit())
bind({ MAIN_MOD, 'w' }, hl.dsp.window.float())
bind({ MAIN_MOD, 'Return' }, hl.dsp.window.fullscreen())

-- Lock screen and logout menu
bind({ MAIN_MOD, 'Backspace' }, exec 'hyprlock')
bind({ MAIN_MOD, 'SHIFT', 'Backspace' }, exec 'wlogout -b 4 -c 0 -r 0 -m 0 --protocol layer-shell')

-- Application shortcuts
bind({ MAIN_MOD, 't' }, exec(constants.Apps.Term))
bind({ MAIN_MOD, 'e' }, exec(constants.Apps.FileManager))
bind({ MAIN_MOD, 'f' }, exec(constants.Apps.Browser))
bind({ 'CTRL', 'SHIFT', 'Escape' }, exec(SRC_PATH .. '/sysmonlaunch.sh'))

-- Rofi
bind({ MAIN_MOD, 'a' }, exec('pkill -x rofi || ' .. SRC_PATH .. '/rofilaunch.sh d'))
bind({ MAIN_MOD, 'tab' }, exec('pkill -x rofi || ' .. SRC_PATH .. '/rofilaunch.sh w'))
bind({ MAIN_MOD, 'r' }, exec('pkill -x rofi || ' .. SRC_PATH .. '/rofilaunch.sh f'))
bind({ MAIN_MOD, 'x' }, exec 'hyprctl kill')
bind({ MAIN_MOD, 'backslash' }, edit_in_nvim, { release = false, repeating = false })

-- Audio control
bind({ 'XF86AudioMute' }, exec(SRC_PATH .. '/volumecontrol.sh -o m'), { locked = true })
bind({ 'XF86AudioMicMute' }, exec(SRC_PATH .. '/volumecontrol.sh -i m'), { locked = true })
bind({ 'XF86AudioLowerVolume' }, exec(SRC_PATH .. '/volumecontrol.sh -o d'), { locked = true, repeatable = true })
bind({ 'XF86AudioRaiseVolume' }, exec(SRC_PATH .. '/volumecontrol.sh -o i'), { locked = true, repeatable = true })
bind({ 'XF86AudioPlay' }, exec 'playerctl play-pause', { locked = true })
bind({ 'XF86AudioPause' }, exec 'playerctl play-pause', { locked = true })
bind({ 'XF86AudioNext' }, exec 'playerctl next', { locked = true })
bind({ 'XF86AudioPrev' }, exec 'playerctl previous', { locked = true })

-- Screenshot / Screencapture
bind({ MAIN_MOD, 'p' }, exec(SRC_PATH .. '/screenshot.sh s'))
bind({ MAIN_MOD, 'ALT', 'p' }, exec(SRC_PATH .. '/screenshot.sh m'))
bind({ 'Print' }, exec(SRC_PATH .. '/screenshot.sh p'))

-- Custom scripts
bind({ MAIN_MOD, 'ALT', 'g' }, exec(SRC_PATH .. '/gamemode.sh'))
bind({ MAIN_MOD, 'v' }, exec('pkill -x rofi || ' .. SRC_PATH .. '/cliphist.sh c'))

-- Move focus
bind({ MAIN_MOD, 'h' }, hl.dsp.focus { direction = 'l' })
bind({ MAIN_MOD, 'j' }, hl.dsp.focus { direction = 'd' })
bind({ MAIN_MOD, 'k' }, hl.dsp.focus { direction = 'u' })
bind({ MAIN_MOD, 'l' }, hl.dsp.focus { direction = 'r' })

-- Switch workspaces
for i = 1, 9 do
  bind({ MAIN_MOD, tostring(i) }, hl.dsp.focus { workspace = tostring(i) })
end

bind({ MAIN_MOD, '0' }, hl.dsp.focus { workspace = '10' })

-- Move workspace to monitor
bind({ MAIN_MOD, 'CTRL', 'h' }, hl.dsp.workspace.move { monitor = constants.Monitors.Secondary })
bind({ MAIN_MOD, 'CTRL', 'l' }, hl.dsp.workspace.move { monitor = constants.Monitors.Primary })

-- Relative workspaces
bind({ MAIN_MOD, 'CTRL', 'k' }, hl.dsp.focus { workspace = '-1' })
bind({ MAIN_MOD, 'CTRL', 'j' }, hl.dsp.focus { workspace = '+1' })
bind({ MAIN_MOD, 'CTRL', 'down' }, hl.dsp.focus { workspace = 'empty' })

-- Resize windows
bind({ MAIN_MOD, 'SHIFT', 'h' }, hl.dsp.window.resize { x = -30, y = 0 }, { repeatable = true })
bind({ MAIN_MOD, 'SHIFT', 'j' }, hl.dsp.window.resize { x = 0, y = 30 }, { repeatable = true })
bind({ MAIN_MOD, 'SHIFT', 'k' }, hl.dsp.window.resize { x = 0, y = -30 }, { repeatable = true })
bind({ MAIN_MOD, 'SHIFT', 'l' }, hl.dsp.window.resize { x = 30, y = 0 }, { repeatable = true })

-- Move active window to workspace
for i = 1, 9 do
  bind({ MAIN_MOD, 'SHIFT', tostring(i) }, hl.dsp.window.move { workspace = tostring(i) })
end
bind({ MAIN_MOD, 'SHIFT', '0' }, hl.dsp.window.move { workspace = '10' })

-- Move active window to relative workspace
bind({ MAIN_MOD, 'CTRL', 'ALT', 'k' }, hl.dsp.window.move { workspace = 'r-1' })
bind({ MAIN_MOD, 'CTRL', 'ALT', 'j' }, hl.dsp.window.move { workspace = 'r+1' })

-- Move active window around current workspace
bind({ MAIN_MOD, 'SHIFT', 'CTRL', 'h' }, hl.dsp.window.move { direction = 'l' })
bind({ MAIN_MOD, 'SHIFT', 'CTRL', 'j' }, hl.dsp.window.move { direction = 'd' })
bind({ MAIN_MOD, 'SHIFT', 'CTRL', 'k' }, hl.dsp.window.move { direction = 'u' })
bind({ MAIN_MOD, 'SHIFT', 'CTRL', 'l' }, hl.dsp.window.move { direction = 'r' })

-- Scroll through workspaces
bind({ MAIN_MOD, 'SHIFT', 'mouse_up' }, hl.dsp.focus { workspace = 'e+1' })
bind({ MAIN_MOD, 'SHIFT', 'mouse_down' }, hl.dsp.focus { workspace = 'e-1' })

-- Move / resize windows with mouse
bind({ MAIN_MOD, 'mouse:272' }, hl.dsp.window.drag(), { mouse = true })
bind({ MAIN_MOD, 'mouse:273' }, hl.dsp.window.resize(), { mouse = true })

-- Special workspaces
bind({ MAIN_MOD, 'ALT', 's' }, hl.dsp.window.move { workspace = 'special' })
bind({ MAIN_MOD, 'SHIFT', 's' }, hl.dsp.window.move { workspace = 'e+0' })
bind({ MAIN_MOD, 's' }, hl.dsp.workspace.toggle_special())

-- Move window silently to workspace
for i = 1, 9 do
  bind({ MAIN_MOD, 'ALT', tostring(i) }, hl.dsp.window.move { workspace = tostring(i), follow = false })
end
bind({ MAIN_MOD, 'ALT', '0' }, hl.dsp.window.move { workspace = '10', follow = false })

-- Scroll layout
bind({ MAIN_MOD, 'period' }, hl.dsp.layout 'move +col')
bind({ MAIN_MOD, 'comma' }, hl.dsp.layout 'move -col')
bind({ MAIN_MOD, 'mouse_up' }, hl.dsp.layout 'move +col')
bind({ MAIN_MOD, 'mouse_down' }, hl.dsp.layout 'move -col')
bind({ MAIN_MOD, 'SHIFT', 'period' }, hl.dsp.layout 'swapcol r')
bind({ MAIN_MOD, 'SHIFT', 'comma' }, hl.dsp.layout 'swapcol l')
