local GTK_THEME = 'Catppuccin-Mocha'
local ICON_THEME = 'Tela-circle-dracula'
local COLOR_SCHEME = 'prefer-dark'

local config_commands = {
  'hyprctl setcursor Bibata-Modern-Ice 20',
  'gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"',
  'gsettings set org.gnome.desktop.interface cursor-size 20',

  -- Fonts
  'gsettings set org.gnome.desktop.interface font-name "CaskaydiaCove Nerd Font Mono"',
  'gsettings set org.gnome.desktop.interface document-font-name "CaskaydiaCove Nerd Font Mono"',
  'gsettings set org.gnome.desktop.interface monospace-font-name "CaskaydiaCove Nerd Font Mono"',
  'gsettings set org.gnome.desktop.interface font-antialiasing "rgba"',
  'gsettings set org.gnome.desktop.interface font-hinting "full"',

  -- Themes
  'gsettings set org.gnome.desktop.interface icon-theme "' .. ICON_THEME .. '"',
  'gsettings set org.gnome.desktop.interface gtk-theme "' .. GTK_THEME .. '"',
  'gsettings set org.gnome.desktop.interface color-scheme "' .. COLOR_SCHEME .. '"',
}

for _, cmd in ipairs(config_commands) do
  hl.exec_cmd(cmd)
end

-- group {
--     col.border_active = rgba(caffffff) rgba(f2d5cfff) 45deg
--     col.border_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
--     col.border_locked_active = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
--     col.border_locked_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
-- }

hl.config {
  general = {
    gaps_in = 4,
    gaps_out = 4,
    border_size = 2,
    col = {
      active_border = {
        colors = { 'rgba(e8003eff)', 'rgba(FF7300ff)', 'rgba(ffbe0bff)', 'rgba(B8D13Bff)', 'rgba(3A86FFff)', 'rgba(8338ECff)', 'rgba(FF006Eff)' },
        angle = 270,
      },
      inactive_border = { colors = { 'rgba(b4befecc)', 'rgba(6c7086cc)' }, angle = 270 },
    },
    layout = 'scrolling',
    resize_on_border = true,
  },
  decoration = {
    rounding = 8,
    shadow = {
      enabled = false,
    },

    dim_special = 0.3,

    blur = {
      enabled = true,
      size = 4,
      passes = 3,
      new_optimizations = true,
      ignore_opacity = true,
      xray = true,
      special = true,
    },
  },
}
