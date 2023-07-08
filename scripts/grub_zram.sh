# UUID for resume and lpj value
lpj_value=$(sudo dmesg | grep "lpj=" | awk -F'lpj=' '{print $2}' | awk '{gsub(/\(|\)/,""); print $1}')

# Install GRUB
if lsblk | grep "efi"; then
  arch-chroot /mnt /bin/bash -c "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch"
else
  arch-chroot /mnt /bin/bash -c "grub-install --target=i386-pc /dev/$disk"
fi

# Add initial settings
arch-chroot /mnt /bin/bash -c "sed -i s/'GRUB_CMDLINE_LINUX_DEFAULT=.*'/'GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=3 quiet splash raid=noautodetect mitigations=off preempt=none nowatchdog audit=0 selinux=0 split_lock_detect=off pci=pcie_bus_perf zswap.enabled=0 ibt=off libahci.ignore_sss=1 nmi_watchdog=0 lpj=$lpj_value\"/g' /etc/default/grub"
arch-chroot /mnt /bin/bash -c "sed -i s/'#GRUB_DISABLE_OS_PROBER=false'/'GRUB_DISABLE_OS_PROBER=false'/g /etc/default/grub"

# Save GRUB config
arch-chroot /mnt /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"
