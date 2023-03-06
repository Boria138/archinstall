#!/bin/bash

arch-chroot /mnt /bin/bash -c "pacman -S --needed xorg xorg-server xorg-xinit ttf-ubuntu-font-family sddm plasma firefox kde-applications pakagekit-qt5"
arch-chroot /mnt /bin/bash -c "systemctl enable sddm"