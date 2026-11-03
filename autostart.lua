local constants = require 'constants'

SRC_PATH = os.getenv 'HOME' .. '/.local/share/bin'

local exec_once = {
  'xrandr --output ' .. constants.PRIMARY_MONITOR .. ' --primary',
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

hl.on('hyprland.start', function()
  for _, cmd in ipairs(exec_once) do
    hl.exec_cmd(cmd)
  end

  hl.timer(function()
    hl.dispatch(hl.dsp.focus { workspace = '10' })
    hl.dispatch(hl.dsp.focus { workspace = '1' })
  end, { type = 'oneshot', timeout = 200 })
end)
