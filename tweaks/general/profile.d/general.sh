# Add .local/bin to PATH
export PATH=~/.local/bin:$PATH

# Fix pip install error if tmp dir is full
export TMPDIR='/var/tmp'

# Set $EDITOR to micro if is empty
if [ -z "$EDITOR"]; then
  export EDITOR=micro 
fi

# Allow npm to run not from sudo (For security)
if pacman -Qi npm &> /dev/null; then
  npm config set prefix ~/.local
fi

# Set kvantum QT engine in GTK DE
if [[ $DESKTOP_SESSION != "plasma" ]]; then
  if [ -z "$QT_QPA_PLATFORMTHEME" ]; then
    if pacman -Qi kvantum &> /dev/null; then
      export QT_STYLE_OVERRIDE=kvantum
    fi
  fi
fi

# Fix cursor bug in GNOME XORG
if [[ $DESKTOP_SESSION == "gnome-xorg" ]]; then
  xset -b off
fi
