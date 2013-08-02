#!/bin/sh
#################################
# What:  Arch-Install-Script   #
# Which: version 6.3          #
# Who:   Cooleech            #
# Under: GPLv2                #
# Contact: cooleechATgmail.com #
#################################
#==============================================================================#
function USER_NAME {
echo " Upišite svoje (korisničko) ime:
"
read Korisnik
Korisnik="${Korisnik%% *}" # Ostavi samo prvu riječ
Korisnik="${Korisnik,,}" # Konverzija u lowercase
clear
if [ "$Korisnik" = "" ]; then
 Korisnik="archie"
 echo "
 Niste upisali ništa pa je korisničko ime postavljeno automatski:

 Korisničko ime: $Korisnik

 Prihvaćate li to ime? (D/n)
 "
 read Prihvat
 Prihvat="${Prihvat,,}" # Konverzija u lowercase
 clear
 case "$Prihvat" in
 n*)
 clear
 USER_NAME
 esac
fi
}

function ENTER_USER_PASS {
clear
Lozinka1=""
Lozinka2=""
echo "Upišite lozinku za korisnika $Korisnik (neće prikazati unos):"
stty -echo
read Lozinka1
stty echo
if [ "$Lozinka1" = "" ]; then
 read -p "Lozinka ne može biti prazna!
 
 Pritisnite Enter za nastavak..."
 ENTER_USER_PASS
fi
echo "Ponovo upišite lozinku za korisnika $Korisnik (neće prikazati unos):"
stty -echo
read Lozinka2
stty echo
if [ "$Lozinka1" = "$Lozinka2" ]; then
 LozinkaKorisnika="$Lozinka1
$Lozinka2"
else
 read -p "Lozinke se ne podudaraju!
	
 Pritisnite Enter za nastavak..."
 ENTER_USER_PASS
fi
}

function ENTER_ROOT_PASS {
clear
Lozinka3=""
Lozinka4=""
echo "Upišite lozinku za root korisnika (neće prikazati unos):"
stty -echo
read Lozinka3
stty echo
if [ "$Lozinka3" = "" ]; then
 read -p "Lozinka ne može biti prazna!
 
 Pritisnite Enter za nastavak..."
 ENTER_ROOT_PASS
fi
echo "Ponovo upišite lozinku za root korisnika (neće prikazati unos):"
stty -echo
read Lozinka4
stty echo
if [ "$Lozinka3" = "$Lozinka4" ]; then
 RootLozinka="$Lozinka3
$Lozinka4"
else
 read -p "Lozinke se ne podudaraju!
	
 Pritisnite Enter za nastavak..."
 ENTER_ROOT_PASS
fi
}

function PARTITIONING {
echo "
 Prikaz dostupnih diskova:"
fdisk -l
echo "
 Upišite koji disk želite patricionirati BEZ /dev/ i BEZ broja (npr. sda):
"
read OdabraniDisk
OdabraniDisk="${OdabraniDisk,,}"
OdabraniDisk="${OdabraniDisk//'/dev/'/}" # Za svaki slučaj... :)
cfdisk /dev/$OdabraniDisk
if [ $? != 0 ]; then
 clear
 echo " *** GREŠKA ***

 Odabrali ste \"$OdabraniDisk\" disk kojemu cfdisk ne može pristupiti.
 Ponovite odabir diska!"
 read -p " Pritisnite Enter za nastavak ili Ctrl + C za prekid..."
 clear
 PARTITIONING
fi
}

function SEL_ROOT_PARTITION {
clear
lsblk /dev/$OdabraniDisk
echo "
 Upišite brojku particije diska za / (root)
 (samo brojku, bez /dev/$OdabraniDisk):"
read RootPart
if [ "$RootPart" = "" ]; then
 clear
 echo " *** GREŠKA ***

 Root particija *MORA* biti odabrana!"
 SEL_ROOT_PARTITION
fi
}

function NET_DEVICE {
rm -f /etc/udev/rules.d/80-net-name-slot.rules # Ako već postoji
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Preimenuj mrežne uređaje u "stara" imena
clear
echo "
 Pregled dostupnih mrežnih uređaja:
"
iwconfig
echo " Upišite koji uređaj želite koristiti:
 (pokušajte sa eth(broj) ili wlan(broj)
"
read NetUredjaj
NetUredjaj="${NetUredjaj,,}" # To lowercase
case "$NetUredjaj" in
wlan*)
wifi-menu "$NetUredjaj"
if [ $? != 0 ]; then
 NET_DEVICE
fi
;;
eth*)
ip link set $NetUredjaj up
if [ $? != 0 ]; then
 echo " Netočno ime mrežnog uređaja!"
 sleep 2
 NET_DEVICE
fi
;;
"")
clear
echo " Niste upisali mrežni uređaj!
 To je nužno za uspješan nastavak instalacije!"
sleep 2
NET_DEVICE
;;
*)
ip link set $NetUredjaj up
if [ $? != 0 ]; then
 echo " Netočno upisano ime uređaja!"
 sleep 2
 NET_DEVICE
fi
echo " Bežična mreža? (d/N)"
read Bezicno
Bezicno="${Bezicno,,}" # To lowercase
 case "$Bezicno" in
 d*)
 wifi-menu "$NetUredjaj"
 if [ $? != 0 ]; then
  NET_DEVICE
 fi
 esac
;;
esac
}

#==============================================================================#
loadkeys croat # Postavljam tipkovnicu na hrvatski layout
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Provjerit ima li smisla da bude i ovde
setfont Lat2-Terminus16 # Postavljam font (podržava sva naša slova)
clear
echo "
   *************************************************************************
   *   Dobrodošli u pojednostavljenu instalaciju Arch Linuxa by Cooleech   *
   *************************************************************************

 Ova skripta je tu da vam maksimalno olakša Arch Linux instalaciju!
 Za početak, prikupit ćemo neke informacije. Pa, krenimo! :)
 
"
USER_NAME
ENTER_USER_PASS
ENTER_ROOT_PASS
PARTITIONING
SEL_ROOT_PARTITION
RootPart="${RootPart//'/dev/$OdabraniDisk'/}" # Za svaki slučaj... :)
echo " Upišite brojku particije diska za /home
 (samo brojku, bez /dev/$OdabraniDisk, za preskok samo stisnite Enter):"
read HomePart
HomePart="${HomePart//'/dev/$OdabraniDisk'/}" # Za svaki slučaj... :)
if [ "$HomePart" != "" ]; then
 echo "
 Želite li formatirati /dev/$OdabraniDisk$HomePart? (D/n)"
 read Formatiraj
 Formatiraj="${Formatiraj,,}"
fi
echo " Upišite brojku particije za swap
 (samo brojku, bez /dev/$OdabraniDisk, za preskok samo stisnite Enter):"
read SwapPart
SwapPart="${SwapPart//'/dev/$OdabraniDisk'/}" # Za svaki slučaj... :)
if [ "$HomePart" != "" ]; then
 Home="Home: /dev/$OdabraniDisk$HomePart
 "
 OpcijaHome=" (opcionalno za /home)"
fi
if [ "$SwapPart" != "" ]; then
 Swap="Swap: /dev/$OdabraniDisk$SwapPart
 "
fi
clear
lsblk /dev/$OdabraniDisk
echo "
 Pregled postavljenih particija:

 Root: /dev/$OdabraniDisk$RootPart
 $Home$Swap
"
echo " Upišite ime hosta (bez razmaka, prazno za archlinux):
 Pritisnite Enter za nastavak ili Ctrl + C za prekid...
"
read ImeHosta
ImeHosta="${ImeHosta// /}" # Ukloni razmake
ImeHosta="${ImeHosta//'@'/AT}" # Zamjeni znak @
if [ "$ImeHosta" = "" ]; then
 ImeHosta="archlinux"
 echo "$ImeHosta"
fi
NET_DEVICE
sleep 2 # Daj mreži vremena da proradi
echo " Pingam google.com..."
ping -c2 google.com
if [ $? != 0 ]; then
 echo " *** GREŠKA ***

 Nema dostupne internet veze! :( Provjerite kabel ili postavke mrežnog uređaja!
 Da bi se uspješno izvršila, ova instalacija TREBA vezu s internetom!
 "
 read -p " Pritisnite Enter za nastavak ili Ctrl + C za prekid..."
 NET_DEVICE
fi
clear
echo " Želite li da svi korisnici mogu koristiti root ovlasti (sudo)? (D/n)"
read DajSudoOvlasti
DajSudoOvlasti="${DajSudoOvlasti,,}"
case "$DajSudoOvlasti" in
d*)
SudoOvlasti="sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers"
;;
"")
SudoOvlasti="sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers"
esac

echo " Želite li koristiti wicd za upravljanje mrežnim uređajima? (d/N)"
read HocuWicd
HocuWicd="${HocuWicd,,}"
clear
echo " Odaberite jedan od ponuđenih DE-a za instalaciju
 (upišite broj željenog DE-a/WM-a, bez upisivanja ili 0 za preskok)

 0 za preskok instalacije (sami ćete instalirati DE/WM)
 1 za KDE minimal
 2 za MATE
 3 za Xfce4
 4 za LXDE
 5 za Awesome
"
read DEzaInst
echo " Ovo računalo je prijenosno? (d/N)"
read Prijenosnik
Prijenosnik="${Prijenosnik,,}"
case "$Prijenosnik" in
d*)
TouchpadDriver=" xf86-input-synaptics libsynaptics"
esac
clear
echo " Ok, to bi bilo sve. Imam dovoljno informacija za nastavak instalacije.
 Samo sjednite i opustite se dok se instalacija ne obavi do kraja. ;)
"
echo " Formatiranje particija..."
if [ "$HomePart" != "" ]; then
 case "$Formatiraj" in
 d*)
 umount -f /mnt/home # Ako je montirana, odmontiraj
 mkfs.ext4 /dev/$OdabraniDisk$HomePart
 ;;
 "")
 umount -f /mnt/home # Ako je montirana, odmontiraj
 mkfs.ext4 /dev/$OdabraniDisk$HomePart
 ;;
 esac
 mkdir /mnt/home # Napravi mapu za montiranje /home particije
 echo " Montiram particiju na /mnt/home..."
 mount /dev/$OdabraniDisk$HomePart /mnt/home # Montiraj particiju
fi
mkfs.ext4 /dev/$OdabraniDisk$RootPart
echo " Montiram particiju na /mnt..."
mount /dev/$OdabraniDisk$RootPart /mnt
if [ "$SwapPart" != "" ]; then
 mkswap /dev/$OdabraniDisk$SwapPart
 echo " Montiram swap particiju..."
 swapon /dev/$OdabraniDisk$SwapPart
fi
clear
echo " Bekapiram mirrorlist..."
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed '/^#\S/ s|#||' -i /etc/pacman.d/mirrorlist.backup # Otkomentiravanje svih mirrora za test brzine
echo " Dodavanje 5 najbržih mirrora. Ovo će malo potrajati."
rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
echo " Osvježavanje liste..."
pacman -Syy
echo " Instalacija osnovnog sustava..."
pacstrap /mnt base base-devel
echo " Generiranje fstab datoteke..."
genfstab -p /mnt | sed 's/rw,relatime,data=ordered/defaults,relatime/' >> /mnt/etc/fstab
echo " Stvaram ArchChroot skriptu..."

#==============================================================================#
echo "#!/bin/sh
#################################
# What:  ArchChroot            #
# Which: version 6.3          #
# Who:   Cooleech            #
# Under: GPLv2                #
# Contact: cooleechATgmail.com #
#################################

case \"$DEzaInst\" in
2*)
echo \"
[mate]
SigLevel = Optional TrustAll
Server = http://repo.mate-desktop.org/archlinux/$(uname -m)\" >> /etc/pacman.conf
esac

ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules
loadkeys croat
echo \"$RootLozinka\" > /tmp/rootpass
passwd < /tmp/rootpass
rm -f /tmp/rootpass
useradd -m -g users -G wheel,storage,power -s /bin/bash $Korisnik
echo \"$LozinkaKorisnika\" > /tmp/userpass
passwd $Korisnik < /tmp/userpass
rm -f /tmp/userpass
echo \" Generiranje engleskog i hrvatskog jezika...\"
sed -i 's/#en_US/en_US/g' /etc/locale.gen
sed -i 's/#hr_HR/hr_HR/g' /etc/locale.gen
locale-gen
echo \"LANG=en_US.UTF-8\" > /etc/locale.conf
export LANG=en_US.UTF-8
echo \" Postavljam keymap i font u vconsole.conf...\"
echo \"KEYMAP=croat
FONT=Lat2Terminus16\" > /etc/vconsole.conf
echo \" Postavljam zonu lokalnog vremena...\"
ln -s /usr/share/zoneinfo/Europe/Zagreb /etc/localtime
echo \" Postavljam hwclock na UTC...\"
hwclock --systohc --utc
echo \" Postavljam ime hosta ($ImeHosta)...\"
echo \"$ImeHosta\" > /etc/hostname
pacman -Sy
pacman -S --noconfirm alsa-plugins alsa-utils dialog dosfstools gksu grub-bios gstreamer0.10-plugins gvfs firefox flac flashplugin lshw mesa mtools ntfs-3g ntp os-prober perl-data-dump sudo transmission-gtk ttf-dejavu ttf-droid ttf-liberation ttf-ubuntu-font-family wget wireless_tools wpa_actiond wpa_supplicant xcursor-vanilla-dmz xdg-user-dirs xf86-input-evdev xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-nv xf86-video-sis xf86-video-vesa xf86-video-v4l xorg-xclock xorg-server xorg-xinit xorg-server-utils xterm vorbis-tools$TouchpadDriver
echo \"Podešavam gvfs...\"
echo \"polkit.addRule(function(action, subject) {
if (action.id.indexOf(\\\"org.freedesktop.udisks2.\\\") == 0){
       return polkit.Result.YES;
   }
}
);\" > /usr/share/polkit-1/rules.d/10-drives.rules
echo \" Uređujem ntp.conf...\"
sed -i 's/pool.ntp.org/pool.ntp.org iburst/g' /etc/ntp.conf
echo \" Podešavam vrijeme pomoću ntpd servisa...\"
ntpd -qg
echo \" Podešavam sat...\"
hwclock -w
case \"\$HocuWicd\" in
d*)
echo \"Instaliram wicd i wicd-gtk...\"
pacman -S --noconfirm wicd wicd-gtk
systemctl -f enable wicd.service
gpasswd -a $Korisnik network
;;
*)
echo \" Instaliram ifplugd...\"
pacman -S --noconfirm ifplugd
echo \" Konfiguriram netctl...\"
cp /etc/netctl/examples/ethernet-dhcp /etc/netctl/
netctl enable ethernet-dhcp
netctl start ethernet-dhcp
systemctl enable netctl-ifplugd@ethernet-dhcp.service
;;
esac
echo \"
 Instalacija GRUB bootloadera...\"
grub-install --target=i386-pc --recheck /dev/$OdabraniDisk
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
$SudoOvlasti
case \"$DEzaInst\" in
1*)
echo \" Pokrećem minimalnu instalaciju KDE-a...\"
pacman -S --noconfirm kdebase kdebase-workspace kdemultimedia-kmix oxygen-gtk2 oxygen-gtk3 phonon-gstreamer # opcionalno: kde-l10n-en_us kde-l10n-hr_hr
systemctl -f enable kdm.service
echo \" Stvaram .xinitrc datoteku u mapi /home/$Korisnik/\"
echo \"exec startkde\" >> /home/$Korisnik/.xinitrc
;;
2*)
echo \" Pokrećem instalaciju MATE-a...\"
pacman -S --noconfirm mate mate-extras gtk-engine-murrine slim
systemctl -f enable slim.service
echo \" Dodajem korisnika $Korisnik na listu SLiM login managera...\"
sed -i 's/#default_user        simone/default_user        $Korisnik/g' /etc/slim.conf
echo \" Stvaram .xinitrc datoteku u mapi /home/$Korisnik/\"
echo \"exec mate-session\" >> /home/$Korisnik/.xinitrc
;;
3*)
echo \" Pokrećem instalaciju Xfce4 DE-a...\"
pacman -S --noconfirm deadbeef file-roller parole thunar-archive-plugin thunar-volman xfce4 xfce4-goodies xfce4-notifyd zenity slim #gvfs-smb
systemctl -f enable slim.service
echo \" Dodajem korisnika $Korisnik na listu SLiM login managera...\"
sed -i 's/#default_user        simone/default_user        $Korisnik/g' /etc/slim.conf
echo \" Stvaram .xinitrc datoteku u mapi /home/$Korisnik/\"
echo \"exec startxfce4\" >> /home/$Korisnik/.xinitrc
;;
4*)
echo \" Pokrećem instalaciju LXDE-a...\"
pacman -S --noconfirm file-roller lxde lxdm leafpad gnome-mplayer gnome-themes-standard zenity
systemctl -f enable lxdm.service
echo \" Stvaram .xinitrc datoteku u mapi /home/$Korisnik/\"
echo \"exec startlxde\" >> /home/$Korisnik/.xinitrc
;;
5*)
echo \" Pokrećem instalaciju Awesome WM-a...\"
pacman -S --noconfirm awesome
echo \"exec awesome\" >> /home/$Korisnik/.xinitrc
;;
\"\")
echo \" INFO:

 Nije instaliran nikakav DE/WM!\"
;;
*)
echo \" INFO:

 Nije instaliran nikakav DE/WM!\"
;;
esac
rm -f /root/.bashrc
rm -f /etc/ArchChroot
echo \" Upišite exit za izlaz...\"
exit" > /mnt/etc/ArchChroot

#==================================================================================================#
clear
echo "sh /etc/ArchChroot" > /mnt/root/.bashrc
arch-chroot /mnt /bin/bash
clear
echo "
 Odmontiravanje montiranih particija..."
if [ "$HomePart" != "" ]; then
 umount /mnt/home
fi
umount /mnt
swapoff -a
echo "
 ****************************
 * * * KRAJ INSTALACIJE * * *
 ****************************

 Sretno uz novoinstaliran Arch! :)
"
read -p " Enter za reboot..."
reboot && eject

### DODATAK SLiM-u - IZBAČENO ALI RADI ###
#echo \"
# Želite li pri podizanju sustava automatski biti ulogirani kao $Korisnik? (d/N)\"
#read AutoLogin
#AutoLogin=\"\${AutoLogin,,}\"
#case \"\$AutoLogin\" in
#d*)
#echo \" Postavljam auto-login...\"
#sed -i 's/#auto_login          no/auto_login          yes/g' /etc/slim.conf
#;;
#*)
#;;
#esac 
