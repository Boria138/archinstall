arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm alsa-utils alsa-firmware alsa-card-profiles alsa-plugins pipewire pipewire-pulse pipewire-alsa pipewire-jack"
cp -rf ../tweaks/pipewire/ /mnt/etc/
