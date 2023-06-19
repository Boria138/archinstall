if pacman -Qi obs-vkcapture &> /dev/nul; then
  if [[ "$XDG_SESSION_TYPE" = "x11" || "$XDG_SESSION_TYPE" = "tty" ]]; then
  	export OBS_USE_EGL=1
  fi
fi 
