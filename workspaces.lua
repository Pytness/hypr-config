local function workspace_number(number, options)
  local tag = tostring(number)

  local parameters = { workspace = tag }

  for k, v in pairs(options) do
    parameters[k] = v
  end

  hl.workspace_rule(parameters)
end

workspace_number(1, { monitor = 'DP-1', default = true })
workspace_number(2, { monitor = 'DP-1' })

workspace_number(8, { monitor = 'DP-1' })
workspace_number(9, { monitor = 'DP-1' })
workspace_number(10, { monitor = 'DP-1', default = true })
