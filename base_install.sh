#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us-acentos" >> /etc/vconsole.conf
echo "arch_desktop" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch_desktop" >> /etc/hosts
sed -i '93s/.//' /etc/pacman.conf
sed -i '94s/.//' /etc/pacman.conf
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
### You can remove the tlp package if you are installing on a desktop or vm
#
pacman -Syy picom man mesa-vdpau mpv mumble ncdu nitrogen nnn nomacs notepadqq materia-gtk-theme mate-icon-theme mate-icon-theme-faenza obs-studio kdenlive okular otf-font-awesome oxygen xclip scrot xf86-video-amdgpu wlroots sway wine-mono wine-gecko waybar vulkan-tools nano telegram-desktop steam steam-native-runtime strongswan snes9x snes9x-gtk simple-scan qbittorrent papirus-icon-theme pavucontrol pamixer pdfarranger networkmanager-strongswan mingw-w64-gcc htop gst-plugins-bad gst-plugins-good gst-plugins-ugly gimp corectrl chromium alacritty arc-icon-theme oxygen-icons-svg efibootmgr networkmanager network-manager-applet dialog mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font xorg lutris wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon 

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

#
#
systemctl enable NetworkManager
# systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
#systemctl enable firewalld
systemctl enable acpid

bootctl --path=/boot install

sed -i 's/#timeout 3/timeout 2/' /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf
echo "console-mode max" >> /boot/loader/loader.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "title Arch Linux" >> /boot/loader/entries/arch-fallback.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch-fallback.conf
echo "initrd /initramfs-linux-fallback.img" >> /boot/loader/entries/arch-fallback.conf

useradd -m bas
echo bas:password | chpasswd
usermod -aG wheel,adm,log,sys bas

printf "\e[1;32mDone! Fix visudo, type exit, umount -a and reboot.\e[0m"
