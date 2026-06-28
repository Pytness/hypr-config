-- env = LIBVA_DRIVER_NAME,nvidia
-- env = XDG_SESSION_TYPE,wayland
-- env = GBM_BACKEND,nvidia-drm
-- env = __GLX_VENDOR_LIBRARY_NAME,nvidia
--
-- cursor {
--     no_hardware_cursors = true
-- }

hl.env('LIBVA_DRIVER_NAME', 'nvidia')
hl.env('XDG_SESSION_TYPE', 'wayland')
hl.env('GBM_BACKEND', 'nvidia-drm')
hl.env('__GLX_VENDOR_LIBRARY_NAME', 'nvidia')

hl.config {
  cursor = {
    no_hardware_cursors = false,
  },
}
