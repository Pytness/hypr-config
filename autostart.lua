local constants = require 'constants'
local utils = require 'utils'

SRC_PATH = os.getenv 'HOME' .. '/.local/share/bin'

local exec_once = {
  'xrandr --output ' .. constants.Monitors.Primary .. ' --primary',
  SRC_PATH .. '/resetxdgportal.sh', -- reset XDPH for screenshare
  SRC_PATH .. '/polkitkdeauth.sh', -- authentication dialogue for GUI apps
  'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP', -- for XDPH
  'dbus-update-activation-environment --systemd --all', -- for XDPH
  'systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP', -- for XDPH
  'wl-paste --type text --watch cliphist store', -- clipboard store text data
  'wl-paste --type image --watch cliphist store', -- clipboard store image data
  'hyprpaper',
  'wayle panel start',
}

local workspace_apps = {
  ['1'] = { 'firefox', {} },
  ['8'] = { 'discord', {} },
  ['9'] = { 'spotify-launcher', {} },
  ['special:special'] = { constants.Apps.Term, {} },
}

--- Handle special case for Enpass, since it has a weird behavior
local function autostart_enpass()
  local cmd = 'QT_QPA_PLATFORM="xcb" /opt/enpass/Enpass -minimize'

  local rules = { workspace = 'special:enpass silent' }

  utils.on_window_open_once({ class = 'Enpass' }, function(window)
    hl.timer(function()
      hl.dispatch(hl.dsp.window.close { window = window })

      -- For some reason, the first time Enpass is started
      -- it doesn't show up, so we skip it for the user
      hl.exec_cmd(cmd)
    end, { type = 'oneshot', timeout = 1000 })
  end)

  hl.exec_cmd(cmd, rules)
end

hl.on('hyprland.start', function()
  for _, cmd in ipairs(exec_once) do
    hl.exec_cmd(cmd)
  end

  -- handle special case for enpass, since it needs to be
  -- started and then closed to avoid it being in the way
  autostart_enpass()

  hl.timer(function()
    hl.dispatch(hl.dsp.focus { workspace = '10' })
    hl.dispatch(hl.dsp.focus { workspace = '1' })
  end, { type = 'oneshot', timeout = 200 })
end)

hl.on('workspace.created', function(ws)
  if ws.is_empty == false then
    return
  end

  local program = workspace_apps[ws.name]

  if program == nil then
    return
  end

  local cmd, app_rules = table.unpack(program)

  local rules = {}
  for k, v in pairs(app_rules) do
    rules[k] = v
  end

  rules.workspace = ws.name .. ' silent'

  hl.exec_cmd(cmd, rules)
end)
