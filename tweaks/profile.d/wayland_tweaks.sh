# Original Script by CachyOS Team
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	if [ -d /sys/module/nvidia ]; then
		export GBM_BACKEND=nvidia-drm
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
	fi
if [[ $DESKTOP_SESSION == "gnome" ]]; then
    export QT_STYLE_OVERRIDE=adwaita-dark
    export XCURSOR_THEME=breeze
    export XCURSOR_SIZE=24
fi
    # QT_QPA_PLATFORM='xcb' best for KDE Framework apps
    export QT_QPA_PLATFORM="wayland;xcb"
    export WINIT_UNIX_BACKEND=x11 # Workaround for Alacritty title bar
    export MOZ_ENABLE_WAYLAND=1
fi
