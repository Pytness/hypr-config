local constants = require 'constants'

hl.monitor {
  output = constants.Monitors.Primary,
  mode = '3840x2160@143',
  position = '1600x0',
  scale = 1.5,
  bitdepth = 10,
  cm = 'wide',
}

hl.monitor {
  output = constants.Monitors.Secondary,
  mode = '2560x1440@60',
  position = '0x0',
  scale = 1.6,
}
