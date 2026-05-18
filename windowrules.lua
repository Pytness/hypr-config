local function match(m, options)
  local parameters = {
    match = m,
  }

  for k, v in pairs(options) do
    parameters[k] = v
  end

  hl.window_rule(parameters)
end

local function match_class(class, options)
  match({ class = class }, options)
end

local function match_initial_class(class, options)
  match({ initial_class = class }, options)
end

local function match_initial_title(title, options)
  match({ initial_title = title }, options)
end

local function match_title(title, options)
  match({ title = title }, options)
end

local function layer_rule(namespace, options)
  local parameters = {
    match = { namespace = namespace },
  }

  for k, v in pairs(options) do
    parameters[k] = v
  end

  hl.layer_rule(parameters)
end

match_class('^(firefox)$', { opacity = '1.00 1.00' })
match_class('^(kitty)$', { opacity = '0.80 0.80' })
match_class('^(org.kde.dolphin)$', { opacity = '0.80 0.80' })
match_class('^(org.kde.ark)$', { opacity = '0.80 0.80', float = true })
match_class('^(nwg-look)$', { opacity = '0.80 0.80', float = true })
match_class('^(qt5ct)$', { opacity = '0.80 0.80', float = true })
match_class('^(qt6ct)$', { opacity = '0.80 0.80', float = true })
match_class('^(kvantummanager)$', { opacity = '0.80 0.80', float = true })
match_class('^(org.pulseaudio.pavucontrol)$', { opacity = '0.80 0.70', float = true })
match_class('^(blueman-manager)$', { opacity = '0.80 0.70', float = true })
match_class('^(nm-applet)$', { opacity = '0.80 0.70', float = true })
match_class('^(nm-connection-editor)$', { opacity = '0.80 0.70', float = true })
match_class('^(org.kde.polkit-kde-authentication-agent-1)$', { opacity = '0.80 0.70', float = true })
match_class('^(polkit-gnome-authentication-agent-1)$', { opacity = '0.80 0.70' })
match_class('^(org.freedesktop.impl.portal.desktop.gtk)$', { opacity = '0.80 0.70' })
match_class('^(org.freedesktop.impl.portal.desktop.hyprland)$', { opacity = '0.80 0.70' })
match_class('^([Ss]team)$', { opacity = '0.70 0.70' })
match_class('^(steamwebhelper)$', { opacity = '0.70 0.70' })
match_class('^([Ss]potify)$', { opacity = '0.70 0.70' })
match_initial_title('^(Spotify Free)$', { opacity = '0.70 0.70' })
match_initial_title('^(Spotify Premium)$', { opacity = '0.70 0.70' })
match_initial_class('^(spotify)$', { workspace = 8 })

match_class('^(com.obsproject.Studio)$', { opacity = '0.80 0.80' })
match_class('^(discord)$', { opacity = '0.80 0.80' })

match({ class = '^(org.kde.dolphin)$', title = '^(Progress Dialog — Dolphin)$' }, { float = true })
match({ class = '^(org.kde.dolphin)$', title = '^(Copying — Dolphin)$' }, { float = true })
match_title('^(About Mozilla Firefox)$', { float = true })
match({ class = '^(firefox)$', title = '^(Picture-in-Picture)$' }, { float = true })
match({ class = '^(firefox)$', title = '^(Library)$' }, { float = true })
match_class('^(vlc)$', { float = true })

match_class('^(eog)$', { float = true })

match_title('^(Open)$', { float = true })
match_title('^(Choose Files)$', { float = true })
match_title('^(Save As)$', { float = true })
match_title('^(Confirm to replace files)$', { float = true })
match_title('^(File Operation Progress)$', { float = true })
match_class('^(xdg-desktop-portal-gtk)$', { float = true })

match_title('(Enpass Assistant)', { float = true, center = true, size = '40% 40%' })
match_class('^(Enpass)$', { float = true })

-- layerrule = blur on, ignore_alpha 0, match:namespace rofi
-- layerrule = blur on, ignore_alpha 0, match:namespace notifications
-- layerrule = blur on, ignore_alpha 0, match:namespace swaync-notification-window
-- layerrule = blur on, ignore_alpha 0, match:namespace swaync-control-center
-- layerrule = blur on, match:namespace logout_dialog

layer_rule('rofi', { blur = true, ignore_alpha = 0 })
layer_rule('notifications', { blur = true, ignore_alpha = 0 })
layer_rule('swaync-notification-window', { blur = true, ignore_alpha = 0 })
layer_rule('swaync-control-center', { blur = true, ignore_alpha = 0 })
layer_rule('logout_dialog', { blur = true })
