#!/bin/bash

#
#  Arch Linux Install (Archinstall)
#------------------------------------------|
#           :
# Author    : Forked by Barry
#           :
# Based on  : https://github.com/linuxshef/archinstall
#           :
# License   : LGPL-3.0 (http://opensource.org/licenses/lgpl-3.0.html)
#           :
#----------------------------------------------------------------------|
clear
echo '
 $$$$$$\                      $$\       $$\                       $$\               $$\ $$\
$$  __$$\                     $$ |      \__|                      $$ |              $$ |$$ |
$$ /  $$ | $$$$$$\   $$$$$$$\ $$$$$$$\  $$\ $$$$$$$\   $$$$$$$\ $$$$$$\    $$$$$$\  $$ |$$ |
$$$$$$$$ |$$  __$$\ $$  _____|$$  __$$\ $$ |$$  __$$\ $$  _____|\_$$  _|   \____$$\ $$ |$$ |
$$  __$$ |$$ |  \__|$$ /      $$ |  $$ |$$ |$$ |  $$ |\$$$$$$\    $$ |     $$$$$$$ |$$ |$$ |
$$ |  $$ |$$ |      $$ |      $$ |  $$ |$$ |$$ |  $$ | \____$$\   $$ |$$\ $$  __$$ |$$ |$$ |
$$ |  $$ |$$ |      \$$$$$$$\ $$ |  $$ |$$ |$$ |  $$ |$$$$$$$  |  \$$$$  |\$$$$$$$ |$$ |$$ |
\__|  \__|\__|       \_______|\__|  \__|\__|\__|  \__|\_______/    \____/  \_______|\__|\__|


'
sleep 2
clear
echo '
                                    ArchInstall
         ─────────────────────────────────────────────────────────────────────────


                 ██╗      ██████╗  █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
                 ██║     ██╔═══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
                 ██║     ██║   ██║███████║██║  ██║██║██╔██╗ ██║██║  ███╗
                 ██║     ██║   ██║██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
                 ███████╗╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝██╗██╗██╗
                 ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝╚═╝


         ─────────────────────────────────────────────────────────────────────────
'
sed -i s/'#en_US.UTF-8'/'en_US.UTF-8'/g /etc/locale.gen
sed -i s/'#ru_RU.UTF-8'/'ru_RU.UTF-8'/g /etc/locale.gen
echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
setfont cyr-sun16
locale-gen
sudo pacman-key --init               
sudo pacman-key --populate archlinux 
sudo pacman-key --refresh-keys     
sudo pacman -Sy      
clear
echo '
                                    Настройка часового пояса

              .──────────────────────────────────────────────────────────────.
              .                                                              .
              .                                                              .
              .  Настройка региона выставляет часовой пояс и время согласно  .
              .                                                              .
              .                      указаному региону                       .
              .                                                              .
              .  Название региона можно посмотреть в списке регионов или     .
              .                                                              .
              .  ввести вручную , если уже знаете , именно в таком формате   .
              .                                                              .
              .                  Пример -->   Europe/Moscow                 .
              .                                                              .
              .                                                              .
              .──────────────────────────────────────────────────────────────.

                              Выберите один из варинтов :

'
read -p "
                        -> Введите значение : " region

ln -sf /usr/share/zoneinfo/$region /etc/localtime
hwclock --systohc
clear

echo '
                                        Имя хоста
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                                                           .
                .                   Укажите имя хоста                       .
                .                                                           .
                .───────────────────────────────────────────────────────────.
'
read -p "
                    -> Введите имя хоста:  " hostname
clear

echo $hostname >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

echo '
                                        Пароль root
                .───────────────────────────────────────────────────────────.
                .                                                           .
                .                                                           .
                .                   Укажите пароль Root !                    .
                .                                                           .
                .          Внимание ! Запомните логин рут , здесь - root    .
                .                                                           .
                .              И пароль тот который вы щас зададите         .
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
              .  Выберите один из варинтов ядра ,для установки системы :     .
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
                                 -> Linux ( 1 ) "
echo -e "\t
                                 -> Linux-zen ( 2 )"
echo -e "\t
                                 -> Linux-lts ( 3 )"
echo -n "
                                 -> Введите значение : "
read main_menu
      case "$main_menu" in

         "1" ) clear ; pacman -S base base-devel linux linux-headers linux-firmware dosfstools btrfs-progs iucode-tool archlinux-keyring bluez bluez-utils micro git --noconfirm
         ;;
         "2" ) clear ; pacman -S base base-devel linux-zen linux-zen-headers linux-firmware dosfstools btrfs-progs iucode-tool archlinux-keyring bluez bluez-utils micro git --noconfirm
         ;;
         "3" ) clear ; pacman -S base base-devel linux-lts linux-lts-headers linux-firmware dosfstools btrfs-progs iucode-tool archlinux-keyring bluez bluez-utils micro git --noconfirm
      esac

clear

echo '
                                     Драйвера видеокарты

              .─────────────────────────────────────────────────────────────────.
              .                                                                 .
              .                                                                 .
              .     Добро пожаловать в меню установки графических драйверов     .
              .                                                                 .
              .  На этом этапе будут установлены драйверы для вашей видеокарты  .
              .                                                                 .
              .                                                                 .
              .                                                                 .
              .─────────────────────────────────────────────────────────────────.

'
echo -e "\t
                          -> Для графики Intel введите   ( 1 ) "
echo -e "\t

                          -> Для графики AMD введите   ( 2 )  "
echo -e "\t

                          -> Для графики Nvidia введите   ( 3 ) "
echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) ./setings/intel_drivers.sh
        ;;
         "2" ) ./setings/amd_drivers.sh
        ;;
         "3" ) ./setings/nvidia_drivers.sh
      esac

clear

echo '
                                     Микрокод для процессора

              .──────────────────────────────────────────────────────────────────.
              .                                                                  .
              .                                                                  .
              .     Добро пожаловать в меню установки Микрокода для процессора   .
              .                                                                  .
              .  На этом этапе будут установлены Микрокоды для вашего процессора .
              .                                                                  .
              .                                                                  .
              .                                                                  .
              .──────────────────────────────────────────────────────────────────. 

'
echo -e "\t
                          -> Для процессора Intel введите   ( 1 ) "
echo -e "\t

                          -> Для процессора AMD введите   ( 2 )  "
echo -n "

                          -> Введите значение : "
read main_menu
      case "$main_menu" in
         "1" ) pacman -S intel-ucode iucode-tool
        ;;
         "2" ) pacman -S amd-ucode iucode-tool
      esac

clear

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

                       Пожалуйста пдождите , идет настройка скачивания пакетов,

                                  это займет пару мнгновений ) .......

              ─────────────────────────────────────────────────────────────────────────────────────|
'
sleep 4
sed -i s/'#Color'/'Color'/g /etc/pacman.conf
sed -i s/'#ParallelDownloads = 5'/'ParallelDownloads = 5'/g /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sed -i s/'# %wheel ALL=(ALL:ALL) ALL'/'%wheel ALL=(ALL:ALL) ALL'/g /etc/sudoers
./chaotic-aur.sh
pacman -Syy --needed grub efibootmgr networkmanager bash-completion rsync reflector ntfs-3g pulseaudio pulseaudio-alsa pulseaudio-jack xdg-user-dirs xdg-utils realtime-privileges xorg xorg-server xorg-xinit mtools archlinux-keyring yay --noconfirm
reflector --sort rate -l 10 --save /etc/pacman.d/mirrorlist
pacman -Syy
clear
echo '
                                   Графическая оболочка
                .────────────────────────────────────────────────────────.
                .                                                        .
                .                                                        .
                .            Теперь выберите один из вариантов           .
                .                                                        .
                .      Для установки нужной вам графической оболочки     .
                .                                                        .
                .                                                        .
                .────────────────────────────────────────────────────────.
'
echo -e "\t
                                 -> KDE ( 1 ) "
echo -e "\t
                                 -> GNOME ( 2 )"
echo -e "\t
                                 -> I3-WM( 3 )"
echo -e "\t
                                 -> Budgie( 4 )"
echo -n "
                                 -> Введите значение : "
read main_menu
      case "$main_menu" in

         "1" ) clear ; ./DE/kde.sh
         ;;
         "2" ) clear ; ./DE/gnome.sh
         ;;
         "3" ) clear ; ./i3/install.sh
         ;;
         "4" ) clear ; ./DE/budgie.sh
      esac

clear

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

echo "root:$password" | chpasswd
useradd -mG wheel,storage,realtime -s /bin/bash $username
echo "$username:$userpassword" | chpasswd
clear
echo '

───────────────────────────────────────────────────────────────────>
░░░░░░░░░░░░▄▄░░░░░░░░░
░░░░░░░░░░░█░░█░░░░░░░░
░░░░░░░░░░░█░░█░░░░░░░░
░░░░░░░░░░█░░░█░░░░░░░░
░░░░░░░░░█░░░░█░░░░░░░░
███████▄▄█░░░░░██████▄░░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░              Установка успешно завершена .
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█░░░░░░░░░░░░░░█░
▓▓▓▓▓▓█████░░░░░░░░░█░░
██████▀░░░░▀▀██████▀░░░░
  <─────────────────────────────────────────────────────────────────────────────────────────────────────────>

'