#!/bin/bash

arch-chroot /mnt /bin/bash -c "pacman -S --needed xfce4-terminal plasma pakagekit-qt5"
arch-chroot /mnt /bin/bash -c "systemctl enable sddm"
