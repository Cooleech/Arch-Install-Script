#!/bin/sh
#################################
# What	 : Arch-Install-Script	#
# Which	 : version 6.5-31	#
# Who	 : Cooleech		#
# Under  : GPLv2		#
# E-mail : cooleechATgmail.com	#
#################################
#==============================================================================#
function USER_NAME {
clear
echo -e "\n Upišite svoje ( \e[36mkorisničko\e[0m ) ime:\n"
read Korisnik
Korisnik="${Korisnik%% *}" # Ostavi samo prvu riječ
Korisnik="${Korisnik,,}" # Konverzija u lowercase
clear
if [ "$Korisnik" = "" ]; then
 echo -e "\n \e[1;36m* UPOZORENJE *\e[0m\n Niste upisali korisničko ime...\n"
 CONTINUE_OR_CANCEL
 USER_NAME
fi
}

function ENTER_USER_PASS {
clear
Lozinka1=""
Lozinka2=""
echo -e "\n Upišite lozinku za korisnika \e[1;36m$Korisnik\e[0m ( neće prikazati unos ):"
stty -echo
read Lozinka1
stty echo
if [ "$Lozinka1" = "" ]; then
 PASSWORD_EMPTY
 ENTER_USER_PASS
fi
echo -e "\n Ponovo upišite lozinku za korisnika \e[1;36m$Korisnik\e[0m ( neće prikazati unos ):"
stty -echo
read Lozinka2
stty echo
if [ "$Lozinka1" = "$Lozinka2" ]; then
 LozinkaKorisnika="$Lozinka1
$Lozinka2"
else
 PASSWORD_MISMATCH
 ENTER_USER_PASS
fi
}

function ENTER_ROOT_PASS {
clear
Lozinka3=""
Lozinka4=""
echo -e "\n Upišite lozinku za \e[1;31mroot\e[0m korisnika ( neće prikazati unos ):"
stty -echo
read Lozinka3
stty echo
if [ "$Lozinka3" = "" ]; then
 PASSWORD_EMPTY
 ENTER_ROOT_PASS
fi
echo -e "\n Ponovo upišite lozinku za \e[1;31mroot\e[0m korisnika ( neće prikazati unos ):"
stty -echo
read Lozinka4
stty echo
if [ "$Lozinka3" = "$Lozinka4" ]; then
 RootLozinka="$Lozinka3
$Lozinka4"
else
 PASSWORD_MISMATCH
 ENTER_ROOT_PASS
fi
}

function PARTITIONING {
clear
echo -e "\n Prikaz dostupnih diskova:"
fdisk -l
echo -e "\n Upišite koji disk želite patricionirati ( BEZ \e[35m/dev/\e[0m i BEZ \e[35mbrojke\e[0m, npr. \e[36msda\e[0m ):\n"
read Disk
Disk="${Disk,,}"
Disk="${Disk//'/dev/'/}" # Ukloni /dev/ (za svaki slučaj :))
cfdisk /dev/$Disk
if [ $? != 0 ]; then
 clear
 echo -e "\n \e[1;31m* GREŠKA *\e[0m\n\n Odabrali ste \"$Disk\" disk kojemu cfdisk ne može pristupiti.\n Ponovite odabir diska!\n"
 CONTINUE_OR_CANCEL
 PARTITIONING
fi
}

function SEL_ROOT_PARTITION {
clear
echo -e "\n Pregled stanja particija na disku \e[1;33m/dev/$Disk\e[0m\n"
lsblk /dev/$Disk
echo -e "\n Upišite \e[1;36mBROJ\e[0m particije diska za / ( root )\n\t( bez \e[1;33m/dev/$Disk\e[0m, npr. \e[36m 1 \e[0m):"
read RootPart
RootPart="${RootPart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$RootPart" = "" ]; then
 clear
 echo -e "\n \e[1;31m* GREŠKA *\e[0m\n\n Root particija *MORA* biti odabrana!\n"
 CONTINUE_OR_CANCEL
 SEL_ROOT_PARTITION
fi
}

function NET_DEVICE {
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Preimenuj mrežne uređaje u "stara" imena
clear
echo -e "\n Provjeravam konekciju na internet...\n"
ping -c2 google.com
if [ $? != 0 ]; then
 echo -e "\n Želite se spojiti bežično? (D/n)"
 read Spajanje
 Spajanje="${Spajanje,,}"
 case "$Spajanje" in
 d*)
  wifi-menu -o
 ;;
 esac
 sleep 2 && ping -c2 google.com
 if [ $? != 0 ]; then
  echo -e "\n \e[1;31m* GREŠKA *\e[0m\n\n Nema dostupne internet veze! \e[1;31m:(\e[0m Provjerite kabel ili postavke mrežnog uređaja!
 Da bi se uspješno obavila, ova instalacija \e[1;37mTREBA\e[0m vezu s internetom.\n"
  CONTINUE_OR_CANCEL
  NET_DEVICE
 fi
fi
echo -e "\n \e[1;32mSpojeni ste na internet. \e[33m:)\e[0m\n" && sleep 1
}

function CONTINUE_OR_CANCEL {
echo -e " Pritisnite \e[1;32mEnter\e[0m za nastavak ili \e[1;31mCtrl\e[0m + \e[1;31mC\e[0m za prekid instalacije..."
read -p ""
}

function PASSWORD_EMPTY {
clear
echo -e "\n \e[1;31m* GREŠKA *\e[0m\n\n Lozinka ne može biti prazna!\n"
CONTINUE_OR_CANCEL
}

function PASSWORD_MISMATCH {
clear
echo -e "\n \e[1;31m* GREŠKA *\e[0m\n\n Lozinke se ne podudaraju!\n"        
CONTINUE_OR_CANCEL
}
#==============================================================================#
ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Preimenuj mrežne uređaje u "stara" imena
setfont Lat2-Terminus16 # Postavljam font (podržava sva naša slova)
clear
echo -e "\n \e[36m********************************************************************************
 *\tDobrodošli u pojednostavljenu instalaciju \e[1;36mArch Linuxa\e[0m \e[36mby \e[1;36mCooleech\e[0m\t\e[36m*
 ********************************************************************************\e[0m
\n\tOva skripta je tu da vam maksimalno olakša Arch Linux instalaciju!\n
\t\e[31m* * * NAPOMENA: KORISTITE JE NA VLASTITU ODGOVORNOST * * *\n\e[0m
\tZa početak, prikupit ćemo neke informacije. Pa, krenimo! \e[1;33m:)\e[0m\n\n
 Koji raspored tipkovnice ( keyboard layout ) želite koristiti?\n\n \e[36m0\e[0m = \e[36mhrvatski\e[0m ( HR ) <= default\n\n \e[36m1\e[0m = \e[36mamerički\e[0m ( US )\n"
read PostavTipki
case "$PostavTipki" in
0*|"")
 loadkeys croat # Postavi tipkovnicu na hrvatski layout
 Layout="hr"
 echo -e "\n \e[1;36mINFO:\e[0m Postavljen je hrvatski (\e[1;36m HR \e[0m) raspored tipkovnice!\n" && CONTINUE_OR_CANCEL
;;
1*)
 loadkeys us # Postavi tipkovnicu na američki layout
 Layout="us"
 echo -e "\n \e[1;36mINFO:\e[0m Postavljen je američki (\e[1;36m US \e[0m) raspored tipkovnice!\n" && CONTINUE_OR_CANCEL
;;
*)
 loadkeys us # Postavi tipkovnicu na američki layout
 Layout="?"
 echo -e "\n \e[1;36mINFO:\e[0m Pretpostavljam da ste htjeli američku, stoga\n\tpostavljena vam je američka (\e[1;36m US \e[0m) tipkovnica.\n" && CONTINUE_OR_CANCEL
;;
esac
clear
if [ "$Layout" = "?" ]; then
 echo -e "\n Upišite raspored tipkovnice koji želite koristiti nakon instalacije\n\t( npr.\e[1;36m DE\e[0m za njemački raspored, ali\e[1;31m pripazite što upisujete\e[0m )\n"
 read Layout
 Layout="${Layout,,}"
 echo -e "\n Raspored tipkovnice nakon instalacije bit će postavljen na \e[1;36m${Layout^^}\e[0m" && CONTINUE_OR_CANCEL
fi
USER_NAME
ENTER_USER_PASS
ENTER_ROOT_PASS
PARTITIONING
SEL_ROOT_PARTITION
echo -e "\n Upišite \e[1;36mBROJ\e[0m particije diska za /home\n\t( bez \e[1;33m/dev/$Disk\e[0m, za preskok samo Enter ):"
read HomePart
HomePart="${HomePart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$HomePart" != "" ]; then
 echo -e "\n\tŽelite li \e[1;31mformatirati\e[0m /home ( /dev/\e[1;36m$Disk$HomePart\e[0m ) particiju? ( D/n )"
 read Formatiraj
 Formatiraj="${Formatiraj,,}"
fi
case "$Formatiraj" in # Potrebno za info prije početka instalacije
d*|"")
 if [ "$HomePart" != "" ]; then
  Formatirati="da, u ext4\n\t\t( * OPREZ * Svi podaci s /dev/$Disk$HomePart particije bit će izbrisani! )"
 else
  Formatirati="\e[32mnema zasebne /home particije\e[0m"
 fi
;;
*)
 Formatirati="ne"
;;
esac
echo -e "\n Upišite \e[1;36mBROJ\e[0m particije diska za swap\n\t( bez \e[1;33m/dev/$Disk\e[0m, za preskok samo Enter ):"
read SwapPart
SwapPart="${SwapPart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$HomePart" = "" ]; then
 Home=" Home: /dev/$Disk$RootPart ( /home niste odvojili na zasebnu particiju )"
else
 Home=" Home: /dev/$Disk$HomePart"
fi
if [ "$SwapPart" = "" ]; then
 Swap=" Swap: ništa ( niste odabrali swap particiju )"
else
 Swap=" Swap: /dev/$Disk$SwapPart"
fi
clear
echo -e "\n Upišite ime hosta ( bez razmaka, samo Enter za \e[36marchlinux\e[0m ):\n"
read ImeHosta
ImeHosta="${ImeHosta// /}" # Ukloni razmake
ImeHosta="${ImeHosta//'@'/AT}" # Zamjeni znak @
if [ "$ImeHosta" = "" ]; then
 ImeHosta="archlinux"
 echo "$ImeHosta"
fi
NET_DEVICE
clear
echo -e "\n Upišite broj pored DE-a koji želite instalalirati:\n\n \e[36m0\e[0m = \e[36msami ćete kasnije instalirati neki DE ili WM\e[0m <= default\n\n \e[36m1\e[0m = \e[36mKDE\n
 2\e[0m = \e[36mMATE\n\n 3\e[0m = \e[36mXfce\n\n 4\e[0m = \e[36mLXDE\e[0m\n"
read DEzaInst
case "$DEzaInst" in
1*|2*|3*|4*)
 echo -e "\n Želite li pri podizanju sustava automatski biti ulogirani kao \e[1;36m$Korisnik\e[0m? ( D/n )\n"
 read AutoLogin
 AutoLogin="${AutoLogin,,}"
;;
*)
 echo -e "\n \e[1;36mINFO:\e[31m Neće biti instaliran nikakav DE (ili WM),\n pa nakon instalacije možete to napraviti prije izlaska iz chroot okružja. ;)\e[0m\n"
;;
esac
case "$DEzaInst" in
1*|2*|3*|4*)
 echo -e "\n Želite li imati uključen Num Lock pri logiranju u sustav? (D/n))\n"
 read NumLock
 NumLock="${NumLock,,}"
 case "$NumLock" in
 d*|"")
  NumLock="da\e[0m ( bit će uključen pri logiranju )"
 ;;
 *)
  NumLock="ne\e[0m ( neće biti uključen pri logiranju )"
 ;;
 esac
;;
esac
clear
echo -e "\n Ovo računalo je prijenosno? ( d/N )\n"
read Prijenosnik
Prijenosnik="${Prijenosnik,,}"
case "$Prijenosnik" in
d*)
 TouchpadDriver=" xf86-input-synaptics libsynaptics"
;;
esac
clear
echo -e "\n Pregled važnijih postavki:\n\n Korisničko ime: \e[36m$Korisnik\e[0m\n Ime hosta:\t \e[36m$ImeHosta\e[0m\n\n Particije diska:\n
  \e[36mRoot: /dev/$Disk$RootPart\n $Home\n $Swap\e[0m\n\n Formatiranje particija:\n
  /\t\t\e[36mda, u ext4\e[0m\n  /home\t\t\e[1;31m$Formatirati\e[0m\n  swap\t\t\e[36mda ( ako je odabran )\e[0m\n
 Tipkovnica:\t\e[1;36m${Layout^^}\e[0m\n Num Lock:\t\e[1;32m$NumLock\n\n To bi bilo to. Imam dovoljno informacija za nastavak instalacije.\n Samo sjednite i opustite se dok se instalacija ne obavi do kraja. ;)\n"
CONTINUE_OR_CANCEL
clear
echo -e "\n Formatiranje particija...\n"
mkfs.ext4 /dev/$Disk$RootPart && mount /dev/$Disk$RootPart /mnt # Montiraj root particiju
if [ "$HomePart" != "" ]; then
 echo -e "\n Stvaram mapu /mnt/home..."
 mkdir /mnt/home
 case "$Formatiraj" in
 d*)
  echo -e "\n Formatiram /dev/$Disk$HomePart..."
  umount /dev/$Disk$HomePart # Ako je montirana, odmontiraj
  mkfs.ext4 /dev/$Disk$HomePart
 ;;
 "")
  echo -e "\n Formatiram /dev/$Disk$HomePart..."
  umount /dev/$Disk$HomePart # Ako je montirana, odmontiraj
  mkfs.ext4 /dev/$Disk$HomePart
 ;;
 esac
fi
if [ "$SwapPart" != "" ]; then
 mkswap /dev/$Disk$SwapPart && swapon /dev/$Disk$SwapPart # Montiraj swap
fi
clear
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup # Bekapiranje mirrorliste
sed '/^#\S/ s|#||' -i /etc/pacman.d/mirrorlist.backup # Otkomentiraj sve mirrore za test brzine
echo -e "\n Dodavanje 5 najbržih mirrora. Ovo će malo potrajati.\n\n  U međuvremenu, možete posjetiti stranicu udruge \e[32mSO\e[35mK\e[0m:\n\n\t\e[1;34mhttp://sok.hr\e[0m\n"
rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
clear
echo -e "\n Osvježavanje liste...\n"
pacman -Syy
echo -e "\n Instalacija osnovnog sustava...\n"
pacstrap /mnt base base-devel
mount /dev/$Disk$HomePart /mnt/home # Montiraj /home particiju
echo -e "\n Generiranje fstab datoteke...\n"
genfstab -p /mnt | sed 's/rw,relatime,data=ordered/defaults,relatime/' >> /mnt/etc/fstab
#==============================================================================#
echo "#!/bin/sh
#################################
# What	 : ArchChroot		#
# Which  : version 6.5-31	#
# Who	 : Cooleech		#
# Under	 : GPLv2		#
# E-mail : cooleechATgmail.com	#
#################################
ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules
loadkeys croat
echo \"$RootLozinka\" > /tmp/rootpass
passwd < /tmp/rootpass
rm -f /tmp/rootpass
useradd -m -g users -G wheel,storage,power -s /bin/bash $Korisnik
echo \"$LozinkaKorisnika\" > /tmp/userpass
passwd $Korisnik < /tmp/userpass
rm -f /tmp/userpass
echo -e \"\n Generiranje jezika...\"
sed -i 's/#en_IE/en_IE/g' /etc/locale.gen
sed -i 's/#hr_HR/hr_HR/g' /etc/locale.gen
locale-gen
echo \"LANG=en_IE.UTF-8\" > /etc/locale.conf
export LANG=en_IE.UTF-8
echo -e \"\n Postavljam keymap i font u vconsole.conf...\"
echo -e \"KEYMAP=croat\nFONT=Lat2Terminus16\" > /etc/vconsole.conf
echo -e \"\n Postavljam zonu lokalnog vremena...\"
ln -s /usr/share/zoneinfo/Europe/Zagreb /etc/localtime
echo -e \"\n Postavljam hwclock na UTC...\"
hwclock --systohc --utc
echo -e \"\n Postavljam ime hosta...\"
echo \"$ImeHosta\" > /etc/hostname
pacman -Sy --noconfirm alsa-plugins alsa-utils bc dialog dnsmasq dosfstools gksu grub-bios gstreamer0.10-plugins gvfs firefox flac flashplugin lshw mtools network-manager-applet networkmanager-dispatcher-ntpd ntfs-3g ntp os-prober p7zip perl-data-dump openssh transmission-gtk ttf-dejavu ttf-droid wget wireless_tools wpa_actiond wpa_supplicant xcursor-vanilla-dmz xdg-user-dirs xf86-input-evdev xf86-input-keyboard xf86-input-mouse xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-nv xf86-video-sis xf86-video-vesa xf86-video-v4l xorg-xclock xorg-server xorg-xinit xorg-server-utils xterm vorbis-tools$TouchpadDriver
echo -e \"\n Dodajem OpenSSH u systemd...\"
systemctl enable sshd
echo -e \"\n Postavljam tipkovnicu na $Layout layout...\"
echo -e \"Section \\\"InputClass\\\"\n\tIdentifier \\\"system-keyboard\\\"\n\tMatchIsKeyboard \\\"on\\\"\n\tOption \\\"XkbModel\\\" \\\"pc105\\\"
\tOption \\\"XkbLayout\\\" \\\"$Layout\\\"\n\tOption \\\"XkbVariant\\\" \\\"\\\"\nEndSection\" > /etc/X11/xorg.conf.d/20-keyboard.conf
echo -e \"\n Podešavam gvfs...\"
echo -e \"polkit.addRule(function(action, subject) {\n\tif (action.id.indexOf(\\\"org.freedesktop.udisks2.\\\") == 0){\n\t\treturn polkit.Result.YES;\n\t}\n});\" > /usr/share/polkit-1/rules.d/10-drives.rules
echo -e \"\n Uređujem ntp.conf...\"
sed -i 's/pool.ntp.org/pool.ntp.org iburst/g' /etc/ntp.conf
sed -i 's/www.pool.ntp.org iburst/www.pool.ntp.org/g' /etc/ntp.conf # Fix za link
echo -e \"\n Podešavam vrijeme...\"
ntpd -qg
hwclock -w
case \"$DEzaInst\" in
2*)
 echo -e \"\n Omogućujem korištenje mate-keyringa...\"
 echo -e \"#!/bin/bash\n\nsource /etc/X11/xinit/xinitrc.d/30-dbus\neval \\\$(/usr/bin/mate-keyring --start --components=gpg,pkcs11,secrets,ssh)\nexport MATE_KEYRING_CONTROL MATE_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK\" > /home/$Korisnik/.xinitrc
;;
*)
 echo -e \"\n Instalacija gnome-keyringa...\"
 pacman -Sy --noconfirm gnome-keyring
 echo -e \"\n Omogućujem korištenje gnome-keyringa...\"
 echo -e \"#!/bin/bash\n\nsource /etc/X11/xinit/xinitrc.d/30-dbus\neval \\\$(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)\nexport GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK\" > /home/$Korisnik/.xinitrc
;;
esac
echo -e \"\n Konfiguriram Network Manager...\"
systemctl enable NetworkManager
systemctl enable NetworkManager-dispatcher.service && systemctl enable ModemManager.service
echo -e \"\n Dodajem korisnika $Korisnik u network grupu...\"
gpasswd -a $Korisnik network
echo -e \"\n Dodajem policy...\"
echo -e \"polkit.addRule(function(action, subject) {\n\tif (action.id.indexOf(\\\"org.freedesktop.NetworkManager.\\\") == 0 && subject.isInGroup(\\\"network\\\")) {
	\treturn polkit.Result.YES;\n\t}\n});\" > /etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers # ...and sudo for all
case \"$DEzaInst\" in
1*)
 echo -e \"\n Pokrećem minimalnu instalaciju KDE-a...\"
 pacman -Sy --noconfirm kdebase kdebase-workspace kdegraphics-gwenview kdemultimedia-kmix kdeplasma-applets-plasma-nm oxygen-gtk2 oxygen-gtk3 phonon-gstreamer qmmp vlc
 systemctl enable kdm.service
 echo \"auth            optional        pam_gnome_keyring.so\" >> /etc/pam.d/kscreensaver
 echo -e \"exec startkde\" >> /home/$Korisnik/.xinitrc
;;
2*)
 echo -e \"\n Pokrećem instalaciju MATE-a...\"
 pacman -Sy --noconfirm deadbeef gnome-mplayer gtk-engine-murrine mate mate-extra mate-file-manager-open-terminal slim zenity
 systemctl enable slim.service
 echo -e \"exec mate-session\" >> /home/$Korisnik/.xinitrc
;;
3*)
 echo -e \"\n Pokrećem instalaciju Xfce4 DE-a...\"
 pacman -Sy --noconfirm deadbeef file-roller parole slim thunar-archive-plugin thunar-volman xfce4 xfce4-goodies xfce4-notifyd zenity
 systemctl enable slim.service
 echo -e \"exec startxfce4\" >> /home/$Korisnik/.xinitrc
;;
4*)
 echo -e \"\n Pokrećem instalaciju LXDE-a...\"
 pacman -Sy --noconfirm deadbeef file-roller gnome-mplayer gnome-themes-standard lxde lxdm leafpad zenity
 systemctl enable lxdm.service
 echo -e \"exec startlxde\" >> /home/$Korisnik/.xinitrc
;;
*)
 echo -e \"\n \e[1;36mINFO:\e[31m Niste odabrali instalaciju DE-a!\e[0m\n\"
;;
esac
case \"$NumLock\" in
d*)
 echo -e \"\n Uključujem numlock pri logiranju...\"
 if [ -e /usr/share/config/kdm/kdmrc ]; then
  sed -i 's/#NumLock=Off/NumLock=On/g' /usr/share/config/kdm/kdmrc
 fi
 if [ -e /etc/slim.conf ]; then
  sed -i 's/# numlock/numlock/g' /etc/slim.conf
 fi
 if [ -e /etc/lxdm/lxdm.conf ]; then
  sed -i 's/# numlock=0/numlock=1/g' /etc/lxdm/lxdm.conf
 fi
;;
esac
if ! [ -d /home/$Korisnik/Documents ]; then # Dodaj korisničke mape ako ne postoje
 mkdir /home/$Korisnik/Documents
fi
if ! [ -d /home/$Korisnik/Downloads ]; then
 mkdir /home/$Korisnik/Downloads
fi
if ! [ -d /home/$Korisnik/Music ]; then
 mkdir /home/$Korisnik/Music
fi
if ! [ -d /home/$Korisnik/Pictures ]; then
 mkdir /home/$Korisnik/Pictures
fi
if ! [ -d /home/$Korisnik/Public ]; then
 mkdir /home/$Korisnik/Public
fi
if ! [ -d /home/$Korisnik/Templates ]; then
 mkdir /home/$Korisnik/Templates
fi
if ! [ -d /home/$Korisnik/Videos ]; then
 mkdir /home/$Korisnik/Videos
fi
echo -e \"\n Predajem vlasništvo /home/$Korisnik mape korisniku $Korisnik...\"
chown -R $Korisnik /home/$Korisnik
echo -e \"\n Radim xdg-user-dirs-update...\"
xdg-user-dirs-update --force --set DOCUMENTS /home/$Korisnik/Documents # Osvježi xdg-user-dirs
xdg-user-dirs-update --force --set DOWNLOAD /home/$Korisnik/Downloads
xdg-user-dirs-update --force --set MUSIC /home/$Korisnik/Music
xdg-user-dirs-update --force --set PICTURES /home/$Korisnik/Pictures
xdg-user-dirs-update --force --set PUBLICSHARE /home/$Korisnik/Public
xdg-user-dirs-update --force --set TEMPLATES /home/$Korisnik/Templates
xdg-user-dirs-update --force --set VIDEOS /home/$Korisnik/Videos
case \"$AutoLogin\" in
d*|\"\")
 echo -e \"\n Postavljam auto-login...\"
 if [ -e /usr/share/config/kdm/kdmrc ]; then
  sed -i 's/#AutoLoginUser=fred/AutoLoginUser=$Korisnik/g' /usr/share/config/kdm/kdmrc
  sed -i 's/#AutoLoginEnable/AutoLoginEnable/g' /usr/share/config/kdm/kdmrc
 fi
 if [ -e /etc/slim.conf ]; then
  sed -i 's/#default_user/default_user/g' /etc/slim.conf && sed -i 's/simone/$Korisnik/g' /etc/slim.conf
  sed -i 's/#auto_login          no/auto_login          yes/g' /etc/slim.conf
 fi
 if [ -e /etc/lxdm/lxdm.conf ]; then
  sed -i 's/# autologin=dgod/autologin=$Korisnik/g' /etc/lxdm/lxdm.conf
 fi
;;
esac
echo -e \"\n Instalacija GRUB bootloadera...\"
grub-install --target=i386-pc --recheck /dev/$Disk
echo -e \"\n Kopiranje GRUB poruka...\"
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
echo -e \"# fix broken grub.cfg gen\nGRUB_DISABLE_SUBMENU=y\" >> /etc/default/grub # Popravi GRUB konfiguraciju
echo -e \"\n Konfiguracija GRUB bootloadera...\"
grub-mkconfig -o /boot/grub/grub.cfg
rm -f /root/.bashrc
rm -f /etc/ArchChroot\"" > /mnt/etc/ArchChroot
#==================================================================================================#
echo -e "sh /etc/ArchChroot\nexit" > /mnt/root/.bashrc
arch-chroot /mnt /bin/bash
clear
echo -e "\n Odmontiravanje montiranih particija..."
umount -R /mnt
swapoff -a
echo -e "\n\e[36m*********************************\n*\t\e[37mKRAJ INSTALACIJE\e[36m\t*\n*********************************\e[0m\n\n Sretno uz novoinstalirani \e[1;36mArch Linux \e[1;33m:)\e[0m\n"
read -p " Enter za reboot..."
reboot
