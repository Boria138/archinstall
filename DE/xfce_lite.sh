#!/bin/bash

arch-chroot /mnt /bin/bash -c "pacman -S --needed gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb xfce4 lightdm lightdm-gtk-greeter"
arch-chroot /mnt /bin/bash -c "systemctl enable lightdm"
