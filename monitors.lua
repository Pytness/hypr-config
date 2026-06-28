local constants = require 'constants'

hl.monitor {
  output = constants.PRIMARY_MONITOR,
  mode = '3840x2160@143',
  position = '1600x0',
  scale = 1.5,
  bitdepth = 10,
  cm = 'wide',
}

hl.monitor {
  output = constants.SECONDARY_MONITOR,
  mode = '2560x1440@60',
  position = '0x0',
  scale = 1.6,
}
