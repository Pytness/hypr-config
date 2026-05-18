-- layerrule = no_anim on, match:namespace hyprpicker
-- layerrule = no_anim on, match:namespace selection
--
-- animations {
--     enabled = yes
--     bezier = wind, 0.05, 0.9, 0.1, 1.05
--     bezier = winIn, 0.1, 1.1, 0.1, 1.1
--     bezier = winOut, 0.3, -0.3, 0, 1
--     bezier = liner, 1, 1, 1, 1
--     animation = windows, 1, 6, wind, slide
--     animation = windowsIn, 1, 6, winIn, slide
--     animation = windowsOut, 1, 5, winOut, slide
--     animation = windowsMove, 1, 5, wind, slide
--     animation = border, 1, 1, liner
--     animation = borderangle, 1, 30, liner, loop
--     animation = fade, 1, 10, default
--     animation = workspaces, 1, 5, wind, slidevert
--     animation = specialWorkspace, 1, 1, wind, slidevert
-- }

hl.curve('wind', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve('winIn', { type = 'bezier', points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve('winOut', { type = 'bezier', points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve('liner', { type = 'bezier', points = { { 1, 1 }, { 1, 1 } } })

hl.animation { leaf = 'windows', duration = 1, speed = 6, bezier = 'wind', style = 'slide', enabled = true }
hl.animation { leaf = 'windowsIn', duration = 1, speed = 6, bezier = 'winIn', style = 'slide', enabled = true }
hl.animation { leaf = 'windowsOut', duration = 1, speed = 5, bezier = 'winOut', style = 'slide', enabled = true }
hl.animation { leaf = 'windowsMove', duration = 1, speed = 5, bezier = 'wind', style = 'slide', enabled = true }
hl.animation { leaf = 'border', duration = 1, speed = 1, bezier = 'liner', enabled = true }
hl.animation { leaf = 'borderangle', duration = 1, speed = 30, bezier = 'liner', style = 'loop', enabled = true }
hl.animation { leaf = 'fade', duration = 1, speed = 10, bezier = 'default', enabled = true }
hl.animation { leaf = 'workspaces', duration = 1, speed = 5, bezier = 'wind', style = 'slidevert', enabled = true }
hl.animation { leaf = 'specialWorkspace', duration = 1, speed = 1, bezier = 'wind', style = 'slidevert', enabled = true }
