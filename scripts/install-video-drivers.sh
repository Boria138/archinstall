#!/bin/bash

nvidia_check_arch(){
    if [[ $(lspci | grep "VGA\|3D" | sed -rn 's/.*(NVIDIA).*/\1/p') ]]; then
        [[ $(lspci | grep VGA | sed -rn 's/.*(G[0-9]*).*/\1/p') == G[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(GT[0-9]*).*/\1/p') == GT[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(MCP[0-9]*).*/\1/p') == MCP[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(GF[0-9]*).*/\1/p') == GF[0-9]* ]] && nv_arch=Fermi
        [[ $(lspci | grep VGA | sed -rn 's/.*(GK[0-9]*).*/\1/p') == GK[0-9]* ]] && nv_arch=Kepler
        [[ $(lspci | grep VGA | sed -rn 's/.*(GM[0-9]*).*/\1/p') == GM[0-9]* ]] && nv_arch=Maxwell
        [[ $(lspci | grep VGA | sed -rn 's/.*(GP[0-9]*).*/\1/p') == GP[0-9]* ]] && nv_arch=Pascal
        [[ $(lspci | grep VGA | sed -rn 's/.*(GV[0-9]*).*/\1/p') == GV[0-9]* ]] && nv_arch=Volta
        [[ $(lspci | grep VGA | sed -rn 's/.*(TU[0-9]*).*/\1/p') == TU[0-9]* ]] && nv_arch=Turing
        [[ $(lspci | grep VGA | sed -rn 's/.*(GA[0-9]*).*/\1/p') == GA[0-9]* ]] && nv_arch=Ampere
        [[ $(lspci | grep VGA | sed -rn 's/.*(AD[0-9]*).*/\1/p') == AD[0-9]* ]] && nv_arch=Ada_Lovelace
    fi
}

nvidia_check_arch

vm=$(systemd-detect-virt)

# Check for Nvidia GPU available
if [[ -n "$nv_arch" ]]; then
    if [[ $nv_arch == Maxwell || $nv_arch == Pascal || $nv_arch == Volta || $nv_arch == Turing || $nv_arch == Ampere || $nv_arch == Ada_Lovelace ]]; then
        arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings egl-wayland vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl ffnvcodec-headers libva-nvidia-driver-git libva-utils inxi mesa-utils"
        cp -rf ./tweaks/nvidia/nvidia.conf /mnt/usr/lib/modprobe.d/90-nvidia-tweaks.conf
        cp -rf ./tweaks/nvidia/nvidia-tweaks.hook /mnt/usr/share/libalpm/hooks/nvidia-tweaks.hook
        cp -rf ./tweaks/nvidia/nvidia-uvm.conf /mnt/etc/modules-load.d/nvidia-tweaks.conf
        cp -rf ./tweaks/nvidia/60-nvidia.rules /mnt/usr/lib/udev/rules.d/71-nvidia.rules
    else
        # Install nouveau if Nvidia proprietary driver not available
        arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver mesa-utils libva-utils inxi nouveau-fw"
    fi
fi
# If Nvidia is not available or Detected Hybrid Graphics - check AMD and Intel GPU

# If amdgpu module available - install amdgpu driver
if [ -d /sys/module/amdgpu ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader mesa-vdpau lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers lib32-vulkan-mesa-layers xf86-video-amdgpu amd-vulkan-prefixes libva-utils mesa-utils inxi"
  cp -rf ./tweaks/amd/* /mnt/etc/modprobe.d/
fi

# If radeon module available - install radeon driver
if [ -d /sys/module/radeon ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa libva-mesa-driver mesa-vdpau mesa-utils libva-utils inxi"
  cp -rf ./tweaks/amd/* /mnt/etc/modprobe.d/
fi

# If i915(Intel) module available - install Intel GPU driver
if [ -d /sys/module/i915 ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader libvdpau-va-gl libva-intel-driver inxi mesa-utils libva-utils vulkan-mesa-layers lib32-vulkan-mesa-layers"
  cp -rf ./tweaks/intel/i915.conf /mnt/etc/modprobe.d/
fi

# If vbox module available - install vbox driver
if [ $vm = "oracle" ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa virtualbox-guest-utils mesa-utils inxi"
  arch-chroot /mnt /bin/bash -c "systemctl enable vboxservice.service"
fi

# If vmware module available - install vmware driver
if [ $vm = "vmware" ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa mesa-utils inxi xf86-input-vmmouse xf86-video-vmware"
fi

# If qemu module available - install qemu driver
if [ $vm = "kvm" ]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm mesa lib32-mesa mesa-utils inxi qemu-guest-agent"
fi

# Install ucode
cpu_model_name=$(cat /proc/cpuinfo | grep vendor | cut -c 13-24 | uniq)

if [[ $cpu_model_name = "GenuineIntel" ]]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm intel-ucode"
fi
if [[ $cpu_model_name = "AuthenticAMD" ]]; then
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm amd-ucode"
fi
