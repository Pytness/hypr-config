local constants = require 'constants'

local function workspace_number(number, options)
  local tag = tostring(number)

  local parameters = { workspace = tag }

  for k, v in pairs(options) do
    parameters[k] = v
  end

  hl.workspace_rule(parameters)
end

workspace_number(8, { monitor = constants.SECONDARY_MONITOR })
workspace_number(9, { monitor = constants.SECONDARY_MONITOR })
workspace_number(10, { monitor = constants.SECONDARY_MONITOR, default = true })

workspace_number(1, { monitor = constants.PRIMARY_MONITOR, default = true })
workspace_number(2, { monitor = constants.PRIMARY_MONITOR })
