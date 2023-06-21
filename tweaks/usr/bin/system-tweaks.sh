#!/bin/bash

# Get the total memory in gigabytes
total_mem=$(free -g | awk '/^Mem:/{print $2}')

# Check if SSD, HDD, or NVMe
if lsblk -d -o rota | grep -q '^0$'; then
  storage_type="ssd"
elif lsblk -d -o tran | grep -q 'nvme'; then
  storage_type="nvme"
else
  storage_type="hdd"
fi

# Check if a swap file or partition exists
if [[ $(swapon --show) ]]; then
  # A swap file or partition exists, set vm.swappiness to 100
  sysctl -w vm.swappiness=100
fi

# Iterate over the block devices and check if they are zram devices
for device in /sys/block/zram*; do
    if [[ -d "$device" ]]; then
      sysctl -w vm.page-cluster=0
    fi
done

# Set vm.dirty_ratio and vm.dirty_background_ratio based on RAM size
if [ $total_mem -le 3 ]; then
    sysctl -w vm.dirty_ratio=10
    sysctl -w vm.dirty_background_ratio=5
elif [ $total_mem -le 15 ]; then
    sysctl -w vm.dirty_ratio=4
    sysctl -w vm.dirty_background_ratio=2
fi

# Set vm.vfs_cache_pressure based on storage type
if [[ $storage_type == "ssd" ||  $storage_type == "nvme" ]]; then
  sysctl -w vm.vfs_cache_pressure=50
  sysctl -w vm.page-cluster=1
elif [[ $total_mem -gt 1 && $storage_type == "hdd" ]]; then
  sysctl -w vm.vfs_cache_pressure=1000
  sysctl -w vm.page-cluster=2
fi

# Reset the latency timer for all PCI devices
sudo setpci -v -s '*:*' latency_timer=20
sudo setpci -v -s '0:0' latency_timer=0

# Find all sound cards
SOUND_CARDS=$(lspci -nd "*:*:04xx" | cut -d " " -f 1)

# Loop through sound cards and set latency timer to 80
for CARD in $SOUND_CARDS; do
    sudo setpci -v -s "$CARD" latency_timer=80
done
