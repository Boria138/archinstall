#!/bin/bash

# Get the available and total memory in gigabytes
available_mem=$(free -g | awk '/Mem/ {print $7}')
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

# Set vm.dirty_ratio and vm.dirty_background_ratio based on available memory
if [ $available_mem -le 5 ]; then
    sysctl -w vm.dirty_ratio=10
    sysctl -w vm.dirty_background_ratio=5
elif [ $available_mem -le 13 ]; then
    sysctl -w vm.dirty_ratio=4
    sysctl -w vm.dirty_background_ratio=2
fi

# Set vm.vfs_cache_pressure based on storage type
if [[ $storage_type == "ssd" ||  $storage_type == "nvme" ]]; then
  sysctl -w vm.vfs_cache_pressure=50
elif [[ $total_mem -gt 1 && $storage_type == "hdd" ]]; then
  sysctl -w vm.vfs_cache_pressure=1000
fi
