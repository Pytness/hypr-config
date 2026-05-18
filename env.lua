local envs = {
  PATH = os.getenv 'PATH' .. ':' .. SRC_PATH,
  XDG_CURRENT_DESKTOP = 'Hyprland',
  XDG_SESSION_TYPE = 'wayland',
  XDG_SESSION_DESKTOP = 'Hyprland',
  QT_QPA_PLATFORM = 'wayland;xcb',
  QT_QPA_PLATFORMTHEME = 'qt6ct',
  QT_WAYLAND_DISABLE_WINDOWDECORATION = '1',
  QT_AUTO_SCREEN_SCALE_FACTOR = '1',
  MOZ_ENABLE_WAYLAND = '1',
  GDK_SCALE = '2',
  DXVK_HDR = '1',
  ENABLE_HDR_WSI = '1',
}

for k, v in pairs(envs) do
  hl.env(k, v)
end
