#!/bin/bash

echo "Idioma..."

sleep 3

loadkeys la-latin1

echo "Conectando al wifi..."

sleep 3

iwctl --passphrase Digna1626 station wlan0 connect "Tenda_78A4D0"

ping -c 3 archlinux.org

sleep 5

lsblk

sleep 5

cfdisk /dev/sda

lsblk

sleep 5

echo "Formateando particiòn boot..."

sleep 3

mkfs.fat -F 32 /dev/sda7

echo "Formateando particiòn root..."

sleep 3

mkfs.ext4 /dev/sda8

echo "Formatiando particiòn home..."

sleep 3

mkfs.ext4 /dev/sda9

echo "Creando y montando carpeta mnt, boot y home..."

sleep 3

mkdir mnt

mount /dev/sda8 /mnt/

mkdir /mnt/boot/

mkdir /mnt/home/

mount /dev/sda7 /mnt/boot/

mount /dev/sda9 /mnt/home/

echo "Ejecutando reflector..."

sleep 3

pacman -Sy reflector python3 --noconfirm

reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

echo "Instalando sistema base..."

sleep 3

pacstrap /mnt base base-devel nano dhcpcd netctl iwd net-tools wireless_tools dialog wpa_supplicant zsh

echo "Generando fstab..."

sleep 3

genfstab -p /mnt >> /mnt/etc/fstab

sleep 3

cat /mnt/etc/fstab

echo ""
echo ""

echo "Idioma..."

sleep 3

echo "Entrando a sistema base..."

sleep 3

arch-chroot /mnt

echo "Idioma..."

nano /etc/locale.gen

locale-gen

echo LANG=es_DO.UTF-8 > /etc/locale.conf

export LANG=es_DO.UTF-8

ln -sf /usr/share/zoneinfo/America/Santo_Domingo /etc/localtime

hwclock -w

echo KEYMAP=la-latin1 > /etc/vconsole.conf

echo archPC > /etc/hostname

echo -e "127.0.0.1\tarchPC\n::1\tarchPC\n127.0.1.1\tarchPC.localdomain archPC" > /etc/hosts

cat /etc/hosts

sleep 3

passwd root

useradd -m -g users -s /bin/zsh cronos

passwd cronos

nano /etc/sudoers

systemctl enable dhcpcd

pacman -Syu

pacman -S reflector

pacman -S git wget neofetch intel-ucode xdg-user-dirs xorg xorg-apps xorg-xinit xorg-twm xterm xorg-xclock xf86-video-intel vulkan-intel

sudo pacman -S android-file-transfer android-tools android-udev msmtp libmtp libcddb gvfs gvfs gvfs-afc
gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google gst-libav geoclue dosfstools mtools jfsutils
f2fs-tools btrfs-progs exfat-utils ntfs-3g reiserfsprogs udftools xfsprogs nilfs-utils polkit gpart ark xarchiver
unarchiver binutils gzip lha lrzip lzip lz4 p7zip tar xz bzip2 p7zip lbzip2 arj lzop cpio unrar unzip zstd zip lzip unarj
zstd pulseaudio pulseaudio-alsa pavucontrol pamixer pulseeffects pulseaudio-equalizer lib32-alsa-plugins
lib32-libpulse pulseaudio-equalizer-ladspa libcanberra-pulse libcanberra-gstreamer ffmpeg aom libde265 x265
x264 libmpeg2 xvidcore libtheora libvpx schroedinger sdl gstreamer gst-plugins-bad gst-plugins-base
gst-plugins-base-libs gst-plugins-good gst-plugins-ugly xine-lib libdvdcss libdvdread dvd+rw-tools lame jasper
openjpeg libmng vcdimager --noconfirm

git clone https://aur.archlinux.org/yay-bin.git

cd yay-bin

makepkg -si

yay -Sy pamac-aur

xdg-user-dirs-update

reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

pacman -S networkmanager ifplugd

systemctl enable NetworkManager

pacman -S xf86-input-synaptics

pacman -S linux-firmware mkinitcpio linux-lts linux-lts-headers

pacman -S grub efibootmgr os-prober

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch

grub-install --target=x86_64-efi --efi-directory=/boot --removable

grub-mkconfig -o /boot/grub/grub.cfg

umount -R /mnt

reboot