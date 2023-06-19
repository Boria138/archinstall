# Original Script by CachyOS Team
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	if [ -d /sys/module/nvidia ]; then
		export GBM_BACKEND=nvidia-drm
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
		export EGL_PLATFORM=wayland
		export QSG_RENDER_LOOP='basic'
	fi
    # fallback to Xwayland for Qt applications 
    export QT_QPA_PLATFORM="wayland;xcb"
    # Workaround for Alacritty title bar
    export WINIT_UNIX_BACKEND=x11
    # Firefox Wayland Support
    export MOZ_ENABLE_WAYLAND=1
    # Wlroots disable hardware cursors and instead use software cursors
    export WLR_NO_HARDWARE_CURSORS=1 
    # Kitty terminal Wayland Support
    export KITTY_ENABLE_WAYLAND=1
fi
