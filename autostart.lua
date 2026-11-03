local constants = require 'constants'

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

hl.on('hyprland.start', function()
  for _, cmd in ipairs(exec_once) do
    hl.exec_cmd(cmd)
  end

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
