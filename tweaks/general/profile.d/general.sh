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

# Fix cursor bug in GNOME XORG
if [[ $DESKTOP_SESSION == "gnome-xorg" ]]; then
  xset -b off
fi
