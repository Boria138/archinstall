#!/bin/bash

arch-chroot /mnt /bin/bash -c "pacman -S --needed gdm-prime python-nautilus gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb gnome gdm gnome-tweaks power-profiles-daemon switcheroo-control gnome-browser-connector"
arch-chroot /mnt /bin/bash -c "systemctl enable gdm"
sleep 3
arch-chroot /mnt /bin/bash -c "dconf write /org/gnome/mutter/check-alive-timeout 'uint32 15000'"
