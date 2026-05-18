-- SRC_PATH = os.getenv 'HOME' .. '/.local/share/bin'

-- hl.bind('SUPER + T', hl.dsp.exec_cmd 'st')
require 'autostart'
require 'env'

hl.config {
  debug = {
    disable_logs = false,
  },

  input = {
    kb_layout = 'us',
    kb_options = 'caps:super',

    follow_mouse = 2,

    touchpad = {
      middle_button_emulation = true,
      natural_scroll = false,
    },

    sensitivity = -0.5,
    accel_profile = 'flat',
    float_switch_override_focus = 0,
  },

  cursor = {
    hide_on_key_press = true,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = 'master',
  },

  misc = {
    vrr = 1,
    disable_hyprland_logo = false,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },

  scrolling = {
    fullscreen_on_one_column = true,
    column_width = 0.9,
    direction = 'right',
  },

  xwayland = {
    force_zero_scaling = true,
    use_nearest_neighbor = false,
  },

  render = {
    non_shader_cm = 1,
  },
}
--

require 'animations'
require 'keybindings'
require 'windowrules'
require 'workspaces'
require 'theme'
require 'monitors'
require 'nvidia'
