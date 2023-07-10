#!/bin/bash

#
#  Arch Linux Install (Arch Install)
#------------------------------------------|
#           :
# Author    : Barry
#           :
# Based on  : https://github.com/linuxshef/archinstall
#           :
# License   : LGPL-3.0 (http://opensource.org/licenses/lgpl-3.0.html)
#           :
#----------------------------------------------------------------------|
setfont cyr-sun16
if grep -q "chaotic-aur" /etc/pacman.conf; then
  echo "Chaotic-AUR уже добавлен!"
else
   pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
   pacman-key --lsign-key 3056513887B78AEB
   pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
   echo -e '\n[chaotic-aur]' >> /etc/pacman.conf
   echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf
fi
clear
echo '
               ─▄▀─▄▀
               ──▀──▀
               █▀▀▀▀▀█▄
               █░░░░░█─█     Добро пожаловать в программу установки Arch Linux
               ▀▄▄▄▄▄▀▀
'
sleep 2
clear
echo '
                                    Настройка часового пояса

              .──────────────────────────────────────────────────────────────.
              .                                                              .
              .                                                              .
              .  Настройка региона выставляет часовой пояс и время согласно  .
              .                                                              .
              .                      указанному региону                       .
              .                                                              .
              .  Название региона можно посмотреть в списке регионов или     .
              .                                                              .
              .  ввести вручную , если уже знаете , именно в таком формате   .
              .                                                              .
              .                  Пример -->   Europe/Moscow                  .
              .                                                              .
              .                                                              .
              .──────────────────────────────────────────────────────────────.

'
read -p "
                        -> Введите значение : " region

clear
echo '
                                      Выбор диска

              .─────────────────────────────────────────────────────────────.
              .                                                             .
              .                                                             .
              .             Введите имя диска для разметки                  .
              .                                                             .
              .   ** Это важно для дальнейшей установки загрузчика GRUB **  .
              .                                                             .
              .         Например ( sda , sdb, sdc , nvme0n1p )              .
              .                                                             .
              .                                                             .
              .─────────────────────────────────────────────────────────────.
'
read -p "
                        -> Введите значение : " disk
clear
echo '
                                        Имя хоста
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                                                           .
                .                   Укажите имя хоста                       .
                .                                                           .
                .                                                           .
                .───────────────────────────────────────────────────────────.

'
read -p "
                    -> Введите имя хоста:  " hostname
clear

echo '
                                        Пароль root
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                   Укажите пароль Root !                   .
                .                                                           .
                .          Внимание ! Запомните логин рут , здесь - root    .
                .                                                           .
                .           И пароль тот который вы сейчас зададите         .
                .                                                           .
                .───────────────────────────────────────────────────────────.
'
read -p "
                    -> Введите пароль root :  " password
clear
echo '

                                Учетная запись пользователя
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                                                           .
                .           Введите имя вашей учетной записи                .
                .                                                           .
                .                                                           .
                .───────────────────────────────────────────────────────────.
'
read -p "
                    -> Введите имя учетной записи :  " username
clear
echo '
                             Пароль учетной записи пользователя
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                                                           .
                .           Укажите пароль вашей учетной записи             .
                .                                                           .
                .                                                           .
                .───────────────────────────────────────────────────────────.
'
read -p "
                    -> Введите пароль пользователя :  " userpassword
clear

echo '
                                     Выбор ядра системы
              .──────────────────────────────────────────────────────────────.
              .                                                              .
              .                                                              .
              .  Выберите один из вариантов ядра ,для установки системы :    .
              .                                                              .
              .   -> С обычным ядром Linux - введите 1                       .
              .                                                              .
              .   -> C производительным ядром Linux-zen - введите 2          .
              .                                                              .
              .   -> С ядром повышеной стабильности Linux-lts - введите 3    .
              .                                                              .
              .                                                              .
              .──────────────────────────────────────────────────────────────.
'
echo -e "\t

                                 -> Linux     ( 1 ) "
echo -e "\t

                                 -> Linux-zen ( 2 )"
echo -e "\t

                                 -> Linux-lts ( 3 )"

echo -n "

                                 -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) clear ; pacstrap /mnt base rate-mirrors rsync base-devel linux linux-headers linux-firmware mkinitcpio-firmware dosfstools ntfs-3g mtools btrfs-progs xfsprogs f2fs-tools iucode-tool archlinux-keyring micro git --noconfirm
         ;;
         "2" ) clear ; pacstrap /mnt base rate-mirrors rsync base-devel linux-zen linux-zen-headers linux-firmware mkinitcpio-firmware dosfstools ntfs-3g mtools btrfs-progs xfsprogs f2fs-tools iucode-tool archlinux-keyring micro git --noconfirm
         ;;
         "3" ) clear ; pacstrap /mnt base rate-mirrors rsync base-devel linux-lts linux-lts-headers linux-firmware mkinitcpio-firmware dosfstools ntfs-3g mtools btrfs-progs xfsprogs f2fs-tools iucode-tool archlinux-keyring micro git --noconfirm
      esac
clear
genfstab -U /mnt >> /mnt/etc/fstab
echo '
───────────────────────────────────────────────────────────────|
──────────────────────
────────────────────── ██████╗  █████╗  ██████╗███╗   ███╗ █████╗ ███╗   ██╗
────────────────────── ██╔══██╗██╔══██╗██╔════╝████╗ ████║██╔══██╗████╗  ██║
──▒▒▒▒▒────▄████▄───── ██████╔╝███████║██║     ██╔████╔██║███████║██╔██╗ ██║
─▒─▄▒─▄▒──███▄█▀────── ██╔═══╝ ██╔══██║██║     ██║╚██╔╝██║██╔══██║██║╚██╗██║
─▒▒▒▒▒▒▒─▐████──█──█── ██║     ██║  ██║╚██████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║
─▒▒▒▒▒▒▒──█████▄────── ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
─▒─▒─▒─▒───▀████▀─────────────────────────────────────────────────────────────────|

                       Пожалуйста подождите , идет настройка скачивания пакетов,

                                  это займет пару мгновений  .......

─────────────────────────────────────────────────────────────────────────────────────|
'
sleep 2
#----------------------------PACMAN Settings----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "sed -i s/'#ParallelDownloads = 5'/'ParallelDownloads = 5'/g /etc/pacman.conf"
arch-chroot /mnt /bin/bash -c "sed -i s/'#VerbosePkgLists'/'VerbosePkgLists'/g /etc/pacman.conf"
arch-chroot /mnt /bin/bash -c "sed -i s/'#Color'/'Color\nILoveCandy'/g /etc/pacman.conf"
arch-chroot /mnt /bin/bash -c "sed -i s/'CheckSpace'/'#CheckSpace'/g /etc/pacman.conf"
arch-chroot /mnt /bin/bash -c "sed -i '/\[multilib\]/,/Include/''s/^#//' /etc/pacman.conf"
#----------------------------Chaotic AUR----------------------------------------------------------------------
if grep -q "chaotic-aur" /mnt/etc/pacman.conf; then
  echo "Chaotic-AUR уже добавлен!"
else
  arch-chroot /mnt /bin/bash -c "pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com"
  arch-chroot /mnt /bin/bash -c "pacman-key --lsign-key 3056513887B78AEB"
  arch-chroot /mnt /bin/bash -c "pacman -U --noconfirm  'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'"
  arch-chroot /mnt /bin/bash -c "echo -e '\n[chaotic-aur]' >> /etc/pacman.conf"
  arch-chroot /mnt /bin/bash -c "echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
fi
arch-chroot /mnt /bin/bash -c "rate-mirrors --allow-root arch | tee /etc/pacman.d/mirrorlist"
arch-chroot /mnt /bin/bash -c "rate-mirrors --allow-root chaotic-aur | tee /etc/pacman.d/chaotic-mirrorlist"
#----------------------------XORG----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Sy --needed --noconfirm xorg xorg-server xorg-xinit xf86-input-libinput xorg-xdpyinfo xorg-xinput xorg-xkill xorg-xrandr"
#----------------------------Fonts----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Syy --needed --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-ms-fonts ttf-meslo-nerd-font-powerlevel10k"
#----------------------------Pipewire----------------------------------------------------------------------
./scripts/pipewire.sh
#----------------------------Network----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Sy --needed --noconfirm bluez-utils bluez firefox firefox-i18n-ru networkmanager"
#----------------------------Utils----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Sy --needed --noconfirm bash-completion os-prober xdg-user-dirs xdg-utils xclip wl-clipboard lrzip zip unrar unzip unace p7zip squashfs-tools hunspell hunspell-en_us hunspell-ru yay grub efibootmgr plymouth"
#----------------------------Gstreamer----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Sy --needed --noconfirm gstreamer gstreamer-vaapi gst-plugins-bad gst-plugin-pipewire gst-plugins-base gst-plugins-good gst-libav gst-plugins-ugly ffmpegthumbnailer"
#----------------------------Optimization----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "pacman -Sy --needed --noconfirm realtime-privileges dbus-broker irqbalance ananicy-cpp ananicy-rules-git memavaild uresourced prelockd"
clear
echo '
──────────────────────────────────────────────────────────────────────────────────────────────────|

 Пожалуйста подождите , идёт определение драйверов для вашей видеокарты и микрокода для процессора

                                это займет пару мгновений  .......

──────────────────────────────────────────────────────────────────────────────────────────────────|
'
./scripts/install-video-drivers.sh
clear
echo '
                                          ZRAM
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Собирайтесь ли вы использовать ZRAM         .
                .                                                        .
                .        (Если вы уже используйте swap ответьте нет)     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Да   ( 1 )"
echo -e "\t

                          -> Нет  ( 2 )"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" )clear ; export zram=1
         ;;
         "2" ) clear ; export zram=0
         clear
         esac
echo '
                                   Графическая оболочка
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .               (Для пропуска нажмите 7)                 .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Для установки KDE введите                  ( 1 )"
echo -e "\t

                          -> Для установки GNOME введите                ( 2 )"
echo -e "\t

                          -> Для установки BUDGIE введите               ( 3 )"
echo -e "\t

                          -> Для установки XFCE введите                 ( 4 )"
echo -e "\t

                          -> Для установки CINNAMON введите             ( 5 )"
echo -e "\t

                          -> Для установки MATE введите                 ( 6 )"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in

         "1" ) clear ; echo '
                                          KDE
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Для установки KDE введите                  ( 1 )"
echo -e "\t

                          -> Для установки KDE облегченная введите      ( 2 )

                                Без пакета    kde-applicatios"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) ./DE/kde.sh
         ;;
         "2" ) ./DE/kde_lite.sh
         clear
         esac
         ;;
         "2" ) clear ; echo '
                                          GNOME
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Для установки GNOME введите                ( 1 )"
echo -e "\t

                          -> Для установки GNOME облегченная введите    ( 2 )

                                Без пакета gnome-extra"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) ./DE/gnome.sh
         ;;
         "2" ) ./DE/gnome_lite.sh
         clear
         esac
         ;;
         "3" ) clear ; echo '
                                          BUDGIE
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Для установки BUDGIE введите               ( 1 )"
echo -e "\t

                          -> Для установки BUGDIE облегченная введите   ( 2 )

                                Без пакета budgie-extras"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) ./DE/budgie.sh
         ;;
         "2" ) ./DE/budgie_lite.sh
         clear
         esac
         ;;
         "4" ) clear ; ./DE/xfce.sh
         ;;
         "5" ) clear ; ./DE/cinnamon.sh
         ;;
         "6" ) clear ; echo '
                                          MATE
                .────────────────────────────────────────────────────────.
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t

                          -> Для установки MATE введите                 ( 1 )"
echo -e "\t

                          -> Для установки MATE облегченная введите     ( 2 )

                                Без пакета mate-extra"

echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) ./DE/mate.sh
         ;;
         "2" ) ./DE/mate_lite.sh
         clear
         esac
         ;;
         "7" ) clear
       esac
clear
#----------------------------Time----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/$region /etc/localtime"
arch-chroot /mnt /bin/bash -c "hwclock --systohc"
#----------------------------Files----------------------------------------------------------------------
touch /mnt/etc/locale.conf
touch /mnt/etc/hostname
#----------------------------Locale----------------------------------------------------------------------
if grep -q "LANG=ru_RU.UTF-8" /mnt/etc/locale.conf; then
  echo "Локаль уже настроенна!"
else
  arch-chroot /mnt /bin/bash -c "sed -i s/'#en_US.UTF-8'/'en_US.UTF-8'/g /etc/locale.gen"
  arch-chroot /mnt /bin/bash -c "sed -i s/'#ru_RU.UTF-8'/'ru_RU.UTF-8'/g /etc/locale.gen"
  arch-chroot /mnt /bin/bash -c "locale-gen"
  arch-chroot /mnt /bin/bash -c "echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf"
  arch-chroot /mnt /bin/bash -c "echo 'KEYMAP=ru' >> /etc/vconsole.conf"
  arch-chroot /mnt /bin/bash -c "echo 'FONT=cyr-sun16' >> /etc/vconsole.conf"
fi
#----------------------------Network----------------------------------------------------------------------
if grep -q "$hostname" /mnt/etc/hostname; then
  echo "Сеть уже настроенна!"
else
  arch-chroot /mnt /bin/bash -c "echo $hostname >> /etc/hostname"
  arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 localhost' >> /etc/hosts"
  arch-chroot /mnt /bin/bash -c "echo '::1       localhost' >> /etc/hosts"
  arch-chroot /mnt /bin/bash -c "echo '127.0.1.1 $hostname.localdomain $hostname' >> /etc/hosts"
fi
#----------------------------Tweaks----------------------------------------------------------------------
cp -rf ./tweaks/general/* /mnt/etc/
cp -rf ./tweaks/usr/bin/* /mnt/usr/bin/
#----------------------------Services----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager bluetooth irqbalance dbus-broker.service ananicy-cpp systemd-oomd uresourced memavaild prelockd system-tweaks.service"
arch-chroot /mnt /bin/bash -c "systemctl --global enable dbus-broker.service"
arch-chroot /mnt /bin/bash -c "systemctl mask plymouth-quit-wait.service"
#----------------------------GRUB----------------------------------------------------------------------
if [ "${zram}" -eq "0" ] ; then
    ./scripts/grub.sh
else
  ./scripts/grub_zram.sh
  arch-chroot /mnt /bin/bash -c "pacman -S --needed --noconfirm zram-generator"
  cp -rf ./tweaks/zram/30-zram.rules /mnt/etc/udev/rules.d/30-zram.rules
  cp -rf ./tweaks/zram/zram-generator.conf /mnt/etc/systemd/zram-generator.conf
fi
#----------------------------initcpio----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "sed -i s/'BINARIES=()'/'BINARIES=(setfont)'/g /etc/mkinitcpio.conf"
arch-chroot /mnt /bin/bash -c "sed -i s/'HOOKS=.*'/'HOOKS=(base systemd plymouth autodetect modconf kms keyboard sd-vconsole block filesystems)'/g /etc/mkinitcpio.conf"
arch-chroot /mnt /bin/bash -c "mkinitcpio -P"
#----------------------------Accounts----------------------------------------------------------------------
arch-chroot /mnt /bin/bash -c "useradd -m -G wheel,storage,rfkill,realtime,video,audio,network -s /bin/bash $username"
arch-chroot /mnt /bin/bash -c "sed -i s/'# %wheel ALL=(ALL:ALL) ALL'/'%wheel ALL=(ALL:ALL) ALL'/g /etc/sudoers"
echo "$username:$userpassword" | arch-chroot /mnt chpasswd
echo "root:$password" | arch-chroot /mnt chpasswd
clear
echo '
───────────────────────────────────────────────────────────────────────────────────────────────────────────>
░░░░░░░░░░░░▄▄░░░░░░░░░
░░░░░░░░░░░█░░█░░░░░░░░
░░░░░░░░░░░█░░█░░░░░░░░
░░░░░░░░░░█░░░█░░░░░░░░
░░░░░░░░░█░░░░█░░░░░░░░
███████▄▄█░░░░░██████▄░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░              Установка успешно завершена . Сейчас компьютер будет перезагружен .
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█████░░░░░░░░░█░░
██████▀░░░░▀▀██████▀░░░
  <─────────────────────────────────────────────────────────────────────────────────────────────────────────>
'
sleep 3
arch-chroot /mnt /bin/bash -c "exit"
umount -R /mnt
clear
reboot
