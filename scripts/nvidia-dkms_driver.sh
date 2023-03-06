#!/bin/bash

arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl"
arch-chroot /mnt /bin/bash -c "sed -i s/'MODULES=()'/'MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'/g /etc/mkinitcpio.conf"