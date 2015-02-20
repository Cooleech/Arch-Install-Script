#!/bin/sh
################################
# What	 : Arch-Install-Script #
# Which	 : version 6.80        #
# Who	 : Cooleech            #
# Where  : GPLv2               #
# Write	 : cooleechATgmail.com #
################################
#==============================================================================#
clear
echo -e "\n \e[1;34mOdaberite jezik instalera\e[0m | \e[1;34mPick installer's language\e[0m:\n\n \e[36mh\e[0m = \e[36mHrvatski\e[0m\t<= default\n\n \e[36me\e[0m = \e[36mEnglish\e[0m\n"
read Language
Language="${Language,,}"
case "$Language" in
e*)
EnterYourUsername="Enter your ( \e[36muser\e[0m ) name"
Warning="WARNING"
NoUsername="You didn't provide any username"
EnterUserPass="Enter password for user"
NoDisplaying="( will not display entered )"
ReenterUserPass="Reenter password for user"
EnterRootPass="Enter password for \e[1;31mroot\e[0m"
ReenterRootPass="Reenter password for \e[1;31mroot\e[0m"
DisplayDisks="Available disks"
EnterDiskToPart="Enter which disk you wish to partition"
Without="WITHOUT"
And="and"
Eg="eg"
Numbers="numbers"
Error="ERROR"
YouPicked="You picked"
DiskAccessError="which cfdisk cannot access.\n Choose a disk again"
ViewPartitions="View of disk partitions"
EnterPartitionNumber="Enter \e[1;36mNUMBER\e[0m of disk partition for"
PartitionError="partition *MUST* be selected"
CheckInternet="Checking internet connection"
ConnectUsingWiFi="Would you like to use wifi connection"
Yn="Y/n"
NoInternet="There's no internet connection! \e[1;31m:(\e[0m Please, check the cable or your net device settings!
 This installation \e[1;37mNEEDS\e[0m internet conection to finish successfuly!"
ContinueOrCancel="Press \e[1;32mEnter\e[0m to continue or \e[1;31mCtrl\e[0m + \e[1;31mC\e[0m to cancel instalation"
PassEmpty="Password cannot be blank"
PassMismatch="Passwords do not match"
Welcome="Welcome to simplified installation of \e[1;36mArch Linux\e[0m"
WhyThisScript="This script is here to simplify Arch Linux install process"
YourRisk="YOU ARE USING IT AT YOUR OWN RISK"
InfoGathering="First, we'll pick some information. So, let's go"
WhichKeyLayout="Which keyboard layout would you like to use"
Croatian="Croatian"
English="English"
Other="Other"
SetCroatian="Now you are using croatian"
SetAmerican="Now you are using american"
KeyboardLayout="keyboard layout"
EnterKeyboardLayout="Enter keyboard layout you wish to use after installation"
GermanEg="for german layout"
LayoutAfterInstall="After installation, keyboard layout will be set to"
ToSkip="to skip, just press \e[1;32mEnter\e[0m"
ToFormat="Would you like to \e[1;31mformat"
Partition="partition"
HomeToExt="yes, into ext4\n\t\t( * WARNING * All data from"
WillBeErased="partition will be erased"
NoSepHomePart="no separate /home partition"
Yes="yes"
No="no"
NoSwapPart="swap partition not selected"
EnterHostName="Enter hostname ( no spaces, just \e[1;32mEnter\e[0m for"
EnterDE="Enter a letter beside the DE you wish to install"
IllPickLater="None. I'll install DE or WM later"
AutoLoginAs="Would you like to use autologin for"
AtLogin="at login"
NumLockOn="Would you like to have Num Lock turned on $AtLogin"
WillBeOn="will be turned on"
WillBeOff="will be turned off"
NoDEorWMinstall="There won't be any DE or WM installation, so after base install you can\n do it by canceling reboot and reentering chroot enviroment manualy"
DEinstNotSel="No DE installaton selected"
ThisIsMobilePC="This PC is mobile (laptop or netbook)"
yN="y/N"
Overview="Important settings overview"
UserName="User name:\t"
HostName="Host name"
DiskPart="Disk partitions"
FormPart="Formating partitions"
YesTo="yes, to"
YesIfSel="yes ( if selected"
KeyLayout="Keyboard"
AllInfoIneed="That's it. I've got enough to proceed with the installation.\n Just sit back and relax until installation finishes"
AddFastMir="Adding 5 fastest mirrors. This will take a while.\n\n  In the meantime, you could visit this nice web-page (in croatian)"
InstallEnd="INSTALLATION ENDED"
EnjoyWith="Enjoy with your new"
EnterTo="Enter to"
;;
*)
EnterYourUsername="Upišite svoje ( \e[36mkorisničko\e[0m ) ime"
Warning="UPOZORENJE"
NoUsername="Niste upisali korisničko ime"
EnterUserPass="Upišite lozinku za korisnika"
NoDisplaying="( neće prikazati unos )"
ReenterUserPass="Ponovo upišite lozinku za korisnika"
EnterRootPass="Upišite lozinku za \e[1;31mroot\e[0m korisnika"
ReenterRootPass="Ponovo upišite lozinku za \e[1;31mroot\e[0m korisnika"
DisplayDisks="Dostupni diskovi"
EnterDiskToPart="Upišite koji disk želite patricionirati"
Without="BEZ"
And="i"
Eg="npr"
Numbers="brojki"
Error="GREŠKA"
YouPicked="Odabrali ste"
DiskAccessError="kojemu cfdisk ne može pristupiti.\n Ponovite odabir diska"
ViewPartitions="Pregled stanja particija na disku"
EnterPartitionNumber="Upišite \e[1;36mBROJ\e[0m particije diska za"
PartitionError="particija *MORA* biti odabrana"
CheckInternet="Provjeravam konekciju na internet"
ConnectUsingWiFi="Želite se spojiti bežično"
Yn="D/n"
NoInternet="Nema dostupne internet veze! \e[1;31m:(\e[0m Provjerite kabel ili postavke mrežnog uređaja!
 Da bi se uspješno obavila, ova instalacija \e[1;37mTREBA\e[0m vezu s internetom"
ContinueOrCancel="Pritisnite \e[1;32mEnter\e[0m za nastavak ili \e[1;31mCtrl\e[0m + \e[1;31mC\e[0m za prekid instalacije"
PassEmpty="Lozinka ne može biti prazna"
PassMismatch="Lozinke se ne podudaraju"
Welcome="Dobrodošli u pojednostavljenu instalaciju \e[1;36mArch Linuxa\e[0m"
WhyThisScript="Ova skripta je tu da vam maksimalno olakša Arch Linux instalaciju"
YourRisk="KORISTITE JE NA VLASTITU ODGOVORNOST"
InfoGathering="Za početak, prikupit ćemo neke informacije. Pa, krenimo"
WhichKeyLayout="Koji raspored tipkovnice ( keyboard layout ) želite koristiti"
Croatian="Hrvatski"
English="Američki"
Other="Ostali"
SetCroatian="Postavljen je hrvatski"
SetAmerican="Postavljen je američki"
KeyboardLayout="raspored tipkovnice"
EnterKeyboardLayout="Upišite raspored tipkovnice koji želite koristiti nakon instalacije"
GermanEg="za njemački raspored"
LayoutAfterInstall="Raspored tipkovnice nakon instalacije bit će postavljen na"
ToSkip="za preskok samo pritisnite \e[1;32mEnter\e[0m"
ToFormat="Želite li \e[1;31mformatirati"
Partition="particiju"
HomeToExt="da, u ext4\n\t\t( * OPREZ * Svi podaci s"
WillBeErased="particije bit će izbrisani"
NoSepHomePart="nema zasebne /home particije"
Yes="da"
No="ne"
NoSwapPart="niste odabrali swap particiju"
EnterHostName="Upišite ime hosta ( bez razmaka, samo \e[1;32mEnter\e[0m za"
EnterDE="Upišite slovo pored DE-a koji želite instalalirati"
IllPickLater="Nijedan. Kasnije ću instalirati DE ili WM"
AutoLoginAs="Želite li biti automatski ulogirani kao"
AtLogin="pri logiranju"
NumLockOn="Želite li imati uključen Num Lock $AtLogin u sustav"
WillBeOn="bit će uključen"
WillBeOff="neće biti uključen"
NoDEorWMinstall="Neće biti instaliran nikakav DE ili WM, no nakon instalacije možete\n otkazati reboot i instalirati što želite ponovnim ulaskom u chroot okruženje"
DEinstNotSel="Niste odabrali instalaciju DE-a"
ThisIsMobilePC="Ovo računalo je prijenosno"
yN="d/N"
Overview="Pregled važnijih postavki"
UserName="Korisničko ime:"
HostName="Ime hosta"
DiskPart="Particije diska"
FormPart="Formatiranje particija"
YesTo="da, u"
YesIfSel="da ( ako je odabran"
KeyLayout="Tipkovnica"
AllInfoIneed="To bi bilo to. Imam dovoljno informacija za nastavak instalacije.\n Samo sjednite i opustite se dok se instalacija ne obavi do kraja"
AddFastMir="Dodavanje 5 najbržih mirrora. Ovo će malo potrajati.\n\n  U međuvremenu, možete posjetiti stranicu udruge"
InstallEnd="KRAJ INSTALACIJE"
EnjoyWith="Sretno uz novoinstalirani"
EnterTo="Enter za"
;;
esac
X11Layouts="af al am ara at az ba bd be bg br brai bt bw by ca cd ch cm cn cz de dk ee epo es et fi fo fr gb ge gh gn gr hr hu ie il in iq ir is it jp ke kg kh kr kz la latam lk lt lv ma mao md me mk ml mm mn mt mv nec_vndr/jp ng nl no np ph pk pl pt ro rs ru se si sk sn sy th tj tm tr tw tz ua us uz vn za"
#==============================================================================#
function ENTER_KEYBOARD_LAYOUT {
clear
echo -e "\n $EnterKeyboardLayout\n\t( $Eg.\e[1;36m DE\e[0m $GermanEg )\n"
read Layout
Layout="${Layout,,}"
case "$X11Layouts" in
*$Layout*)
 echo -e "\n $LayoutAfterInstall \e[1;36m${Layout^^}\e[0m" && CONTINUE_OR_CANCEL
;;
*)
 echo -e "\n \e[31m*** ERROR / GREŠKA ***\e[0m\n\n Bad layout! / Krivi raspored tipki!\n"
 sleep 2
 ENTER_KEYBOARD_LAYOUT
;;
esac
}

function USER_NAME {
clear
echo -e "\n $EnterYourUsername:\n"
read Korisnik
Korisnik="${Korisnik%% *}" # Ostavi samo prvu riječ
Korisnik="${Korisnik,,}" # Konverzija u lowercase
clear
if [ "$Korisnik" = "" ]; then
 echo -e "\n \e[1;36m* $Warning *\e[0m\n $NoUsername...\n"
 CONTINUE_OR_CANCEL
 USER_NAME
fi
}

function ENTER_USER_PASS {
clear
Lozinka1=""
Lozinka2=""
echo -e "\n $EnterUserPass \e[1;36m$Korisnik\e[0m $NoDisplaying:"
stty -echo
read Lozinka1
stty echo
if [ "$Lozinka1" = "" ]; then
 PASSWORD_EMPTY
 ENTER_USER_PASS
fi
echo -e "\n $ReenterUserPass \e[1;36m$Korisnik\e[0m $NoDisplaying:"
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
echo -e "\n $EnterRootPass $NoDisplaying:"
stty -echo
read Lozinka3
stty echo
if [ "$Lozinka3" = "" ]; then
 PASSWORD_EMPTY
 ENTER_ROOT_PASS
fi
echo -e "\n $ReenterRootPass $NoDisplaying:"
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
echo -e "\n $DisplayDisks:"
lsblk | grep -v "rom\|loop\|airoot"
echo -e "\n $EnterDiskToPart ( $Without \e[35m/dev/\e[0m $And $Without \e[35m$Numbers\e[0m, $Eg. \e[36msda\e[0m ):\n"
read Disk
Disk="${Disk,,}"
Disk="${Disk//'/dev/'/}" # Ukloni /dev/ (za svaki slučaj :))
cfdisk /dev/$Disk
if [ $? != 0 ]; then
 clear
 echo -e "\n \e[1;31m* $Error *\e[0m\n\n $YouPicked \"$Disk\" disk $DiskAccessError!\n"
 CONTINUE_OR_CANCEL
 PARTITIONING
fi
}

function SEL_ROOT_PARTITION {
clear
echo -e "\n $ViewPartitions \e[1;33m/dev/$Disk\e[0m\n"
lsblk /dev/$Disk
echo -e "\n $EnterPartitionNumber / ( root )\n\t( $Without \e[1;33m/dev/$Disk\e[0m, $Eg. \e[36m 1 \e[0m):"
read RootPart
RootPart="${RootPart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$RootPart" = "" ]; then
 clear
 echo -e "\n \e[1;31m* $Error *\e[0m\n\n Root $PartitionError!\n"
 CONTINUE_OR_CANCEL
 SEL_ROOT_PARTITION
fi
}

function NET_DEVICE {
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Preimenuj mrežne uređaje u "stara" imena
clear
echo -e "\n $CheckInternet...\n"
ping -c2 google.com
if [ $? != 0 ]; then
 echo -e "\n $ConnectUsingWiFi? ( $Yn )"
 read Spajanje
 Spajanje="${Spajanje,,}"
 case "$Spajanje" in
 d*|y*)
  wifi-menu -o
 ;;
 esac
 sleep 2 && ping -c2 google.com
 if [ $? != 0 ]; then
  echo -e "\n \e[1;31m* $Error *\e[0m\n\n $NoInternet.\n"
  CONTINUE_OR_CANCEL
  NET_DEVICE
 fi
fi
}

function CONTINUE_OR_CANCEL {
echo -e " $ContinueOrCancel..."
read -p ""
}

function PASSWORD_EMPTY {
clear
echo -e "\n \e[1;31m* $Error *\e[0m\n\n $PassEmpty!\n"
CONTINUE_OR_CANCEL
}

function PASSWORD_MISMATCH {
clear
echo -e "\n \e[1;31m* $Error *\e[0m\n\n $PassMismatch!\n"        
CONTINUE_OR_CANCEL
}
#==============================================================================#
ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules # Preimenuj mrežne uređaje u "stara" imena
setfont Lat2-Terminus16 # Postavljam font (podržava sva naša slova)
clear
echo -e "\n\e[36m *******************************************************************************\n\t$Welcome \e[36mby \e[1;36mCooleech\e[0m\t\e[36m\n *******************************************************************************\e[0m
\n\t$WhyThisScript!\n
\t\e[31m* * * $Warning: $YourRisk * * *\n\e[0m
\t$InfoGathering! \e[1;33m:)\e[0m\n\n
 $WhichKeyLayout?\n\n \e[36mh\e[0m = \e[36m$Croatian\e[0m\t( HR ) <= default\n\n \e[36me\e[0m = \e[36m$English\e[0m\t( US )\n\n \e[36mo\e[0m = \e[36m$Other\e[0m\t( ?? )\n"
read PostavTipki
case "$PostavTipki" in
h*|"")
 loadkeys croat # Postavi tipkovnicu na hrvatski layout
 Layout="hr"
 echo -e "\n \e[1;36mINFO:\e[0m $SetCroatian (\e[1;36m HR \e[0m) $KeyboardLayout!\n" && CONTINUE_OR_CANCEL
;;
e*)
 loadkeys us # Postavi tipkovnicu na američki layout
 Layout="us"
 echo -e "\n \e[1;36mINFO:\e[0m $SetAmerican (\e[1;36m US \e[0m) $KeyboardLayout!\n" && CONTINUE_OR_CANCEL
;;
*)
 loadkeys us # Postavi tipkovnicu na američki layout
 Layout="?"
 echo -e "\n \e[1;36mINFO:\e[0m $SetAmerican (\e[1;36m US \e[0m) $KeyboardLayout.\n" && CONTINUE_OR_CANCEL
;;
esac
clear
if [ "$Layout" = "?" ]; then
 ENTER_KEYBOARD_LAYOUT
fi
USER_NAME
ENTER_USER_PASS
ENTER_ROOT_PASS
PARTITIONING
SEL_ROOT_PARTITION
echo -e "\n $EnterPartitionNumber /home\n\t( $Without \e[1;33m/dev/$Disk\e[0m, $ToSkip ):"
read HomePart
HomePart="${HomePart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$HomePart" != "" ]; then
 echo -e "\n\t$ToFormat\e[0m /home ( /dev/\e[1;36m$Disk$HomePart\e[0m ) $Partition? ( $Yn )"
 read Formatiraj
 Formatiraj="${Formatiraj,,}"
fi
case "$Formatiraj" in # Potrebno za info prije početka instalacije
d*|y*|"")
 if [ "$HomePart" != "" ]; then
  Formatirati="$HomeToExt /dev/$Disk$HomePart $WillBeErased! )"
 else
  Formatirati="\e[32m$NoSepHomePart\e[0m"
 fi
;;
*)
 Formatirati="$No"
;;
esac
echo -e "\n $EnterPartitionNumber swap\n\t( $Without \e[1;33m/dev/$Disk\e[0m, $ToSkip ):"
read SwapPart
SwapPart="${SwapPart//'/dev/$Disk'/}" # Za svaki slučaj... :)
if [ "$HomePart" = "" ]; then
 Home=" Home: /dev/$Disk$RootPart ( $NoSepHomePart )"
else
 Home=" Home: /dev/$Disk$HomePart"
fi
if [ "$SwapPart" = "" ]; then
 Swap=" Swap: ništa ( $NoSwapPart )"
else
 Swap=" Swap: /dev/$Disk$SwapPart"
fi
clear
echo -e "\n $EnterHostName \e[36marchlinux\e[0m ):\n"
read ImeHosta
ImeHosta="${ImeHosta// /}" # Ukloni razmake
ImeHosta="${ImeHosta//'@'/AT}" # Zamjeni znak @
if [ "$ImeHosta" = "" ]; then
 ImeHosta="archlinux"
fi
NET_DEVICE
clear
echo -e "\n $EnterDE:\n\n \e[36mN\e[0m = \e[36m$IllPickLater\e[0m <= default\n\n \e[36mK\e[0m = \e[36mKDE\n
 M\e[0m = \e[36mMATE\n\n X\e[0m = \e[36mXfce\n\n L\e[0m = \e[36mLXDE\e[0m\n"
read DEzaInst
DEzaInst="${DEzaInst,,}"
case "$DEzaInst" in
k*|m*|x*|l*)
 echo -e "\n $AutoLoginAs \e[1;36m$Korisnik\e[0m? ( $Yn )\n"
 read AutoLogin
 AutoLogin="${AutoLogin,,}"
 echo -e "\n $NumLockOn? ( $Yn )\n"
 read NumLock
 NumLock="${NumLock,,}"
 case "$NumLock" in
 d*|y*|"")
  NumLock="$Yes ( $WillBeOn $AtLogin )"
 ;;
 *)
  NumLock="$No ( $WillBeOff $AtLogin )"
 ;;
 esac
;;
*)
 echo -e "\n \e[1;36mINFO:\e[31m $NoDEorWMinstall. ;)\e[0m\n"
 NumLock="$No ( $DEinstNotSel )" 
 CONTINUE_OR_CANCEL
;;
esac
clear
echo -e "\n $ThisIsMobilePC? ( $yN )\n"
read Prijenosnik
Prijenosnik="${Prijenosnik,,}"
case "$Prijenosnik" in
d*|y*)
 TouchpadDriver=" xf86-input-synaptics libsynaptics"
;;
esac
clear
echo -e "\n $Overview:\n\n $UserName \e[36m$Korisnik\e[0m\n $HostName:\t \e[36m$ImeHosta\e[0m\n\n $DiskPart:\n
  \e[36mRoot: /dev/$Disk$RootPart\n $Home\n $Swap\e[0m\n\n $FormPart:\n
  /\t\t\e[36m$YesTo ext4\e[0m\n  /home\t\t\e[1;31m$Formatirati\e[0m\n  swap\t\t\e[36m$YesIfSel )\e[0m\n
 $KeyLayout:\t\e[1;36m${Layout^^}\e[0m\n Num Lock:\t\e[1;32m$NumLock\e[0m\n\n $AllInfoIneed. ;)\n"
CONTINUE_OR_CANCEL
clear
echo -e "\n Formatiranje particija...\n"
umount /dev/$Disk$RootPart 2>/dev/null # Ako je montirana, odmontiraj
mkfs.ext4 -Fq /dev/$Disk$RootPart
if [ "$HomePart" != "" ]; then
 case "$Formatiraj" in
 d*|y*|"")
  echo -e "\n Formatiram /dev/$Disk$HomePart..."
  umount /dev/$Disk$HomePart 2>/dev/null # Ako je montirana, odmontiraj
  mkfs.ext4 -Fq /dev/$Disk$HomePart
 ;;
 esac
fi
if [ "$SwapPart" != "" ]; then
 mkswap /dev/$Disk$SwapPart
fi
echo -e "\n Montiram root particiju (/dev/$Disk$RootPart)...\n"
mount /dev/$Disk$RootPart /mnt
if [ $? != 0 ]; then
 echo -e "\n \e[1;31m* $Error *\e[0m\n\n Pritisnite \e[1;32mEnter\e[0m za nastavak...\n Press \e[1;32mEnter\e[0m to continue...\n\n"
 read -p ""
fi
if [ "$HomePart" != "" ]; then
 echo -e "\n Stvaram mapu /mnt/home..."
 mkdir /mnt/home
 echo -e "\n Montiram home particiju (/dev/$Disk$HomePart)...\n"
 mount /dev/$Disk$HomePart /mnt/home
 if [ $? != 0 ]; then
  echo -e "\n \e[1;31m* $Error *\e[0m\n\n Pritisnite \e[1;32mEnter\e[0m za nastavak...\n Press \e[1;32mEnter\e[0m to continue...\n\n"
  read -p ""
 fi
fi
if [ "$SwapPart" != "" ]; then
 echo -e "\n Montiram swap particiju (/dev/$Disk$SwapPart)...\n"
 swapon /dev/$Disk$SwapPart
 if [ $? != 0 ]; then
  echo -e "\n \e[1;31m* $Error *\e[0m\n\n Pritisnite \e[1;32mEnter\e[0m za nastavak...\n Press \e[1;32mEnter\e[0m to continue...\n\n"
  read -p ""
 fi
fi
clear
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup # Bekapiranje mirrorliste
sed '/^#\S/ s|#||' -i /etc/pacman.d/mirrorlist.backup # Otkomentiraj sve mirrore za test brzine
echo -e "\n $AddFastMir \e[32mSO\e[35mK\e[0m:\n\n\t\e[1;34mhttp://sok.hr\e[0m\n"
rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
clear
echo -e "\n Osvježavanje keyringa...\n"
pacman -Sy --noconfirm archlinux-keyring
echo -e "\n Instalacija osnovnog sustava...\n"
pacstrap /mnt base base-devel
if [ $? != 0 ]; then
 echo -e "\n \e[1;31m* $Error *\e[0m\n\n Pritisnite \e[1;32mEnter\e[0m za nastavak...\n Press \e[1;32mEnter\e[0m to continue...\n\n"
 read -p ""
fi
echo -e "\n Generiranje fstab datoteke...\n"
genfstab -p /mnt | sed 's/rw,relatime,data=ordered/defaults,relatime/' >> /mnt/etc/fstab
#==============================================================================#
echo "#!/bin/sh
################################
# What	 : ArchChroot          #
# Which  : version 6.80        #
# Who	 : Cooleech            #
# Where	 : GPLv2               #
# Write	 : cooleechATgmail.com #
################################
ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules
loadkeys croat
echo \"$RootLozinka\" > /tmp/rootpass
passwd < /tmp/rootpass
rm -f /tmp/rootpass
useradd -m -g users -G wheel,storage,power -s /bin/bash $Korisnik
echo \"$LozinkaKorisnika\" > /tmp/userpass
passwd $Korisnik < /tmp/userpass
rm -f /tmp/userpass
echo -e \"\n Uređivanje pacman.conf datoteke...\"
sed -i 's/#Color/Color/g' /etc/pacman.conf
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
pacman-db-upgrade # Fix za starije iso datoteke
pacman -Sy --noconfirm alsa-plugins alsa-utils bc dialog dnsmasq dosfstools gksu grub-bios gstreamer0.10-plugins gvfs firefox flac flashplugin lshw mtools net-tools network-manager-applet networkmanager-dispatcher-ntpd ntfs-3g ntp openssh os-prober p7zip perl-data-dump ttf-dejavu ttf-droid unrar unzip wget wireless_tools wpa_actiond wpa_supplicant xcursor-vanilla-dmz xdg-user-dirs xf86-input-evdev xf86-input-keyboard xf86-input-mouse xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-nv xf86-video-sis xf86-video-vesa xorg-server xorg-server-utils xorg-xclock xorg-xinit xterm vorbis-tools zip$TouchpadDriver
if [ \$? != 0 ]; then
 echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
 read -p \"\"
fi
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
k*|m*|x*|l*)
 echo -e \"\n Instalacija gnome-keyringa i teme gnome-themes-standard...\"
 pacman -Sy --noconfirm gnome-keyring gnome-themes-standard
 if [ \$? != 0 ]; then
  echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
  read -p \"\"
 fi
 echo -e \"\n Omogućujem korištenje gnome-keyringa...\"
 echo -e \"#!/bin/bash\n\nsource /etc/X11/xinit/xinitrc.d/30-dbus\neval \\\$(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)\nexport GPG_AGENT_INFO SSH_AUTH_SOCK\" > /home/$Korisnik/.xinitrc
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
k*)
 echo -e \"\n Pokrećem instalaciju KDE-a...\"
 pacman -Sy --noconfirm gwenview kdebase kdebase-workspace kdegraphics-ksnapshot kdemultimedia-kmix kdeplasma-addons-applets-showdesktop kdeplasma-applets-plasma-nm kdeutils-ark oxygen-gtk2 oxygen-gtk3 vlc
 if [ \$? != 0 ]; then
  echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
  read -p \"\"
 fi
 systemctl enable kdm.service
 echo \"auth            optional        pam_gnome_keyring.so\" >> /etc/pam.d/kscreensaver
 echo -e \"exec startkde\" >> /home/$Korisnik/.xinitrc
;;
m*)
 echo -e \"\n Pokrećem instalaciju MATE-a...\"
 pacman -Sy --noconfirm deadbeef gtk-engine-murrine lxdm mate mate-extra vlc zenity
 if [ \$? != 0 ]; then
  echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
  read -p \"\"
 fi
 systemctl enable lxdm.service
 sed -i 's/startlxde/mate-session/g' /etc/lxdm/Xsession
 sed -i 's/# session/session/g' /etc/lxdm/lxdm.conf
 sed -i 's/startlxde/mate-session/g' /etc/lxdm/lxdm.conf
 echo -e \"exec mate-session\" >> /home/$Korisnik/.xinitrc
;;
x*)
 echo -e \"\n Pokrećem instalaciju Xfce4 DE-a...\"
 pacman -Sy --noconfirm deadbeef lxdm thunar-archive-plugin thunar-volman xarchiver xfce4 xfce4-goodies xfce4-notifyd vlc zenity
 if [ \$? != 0 ]; then
  echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
  read -p \"\"
 fi
 systemctl enable lxdm.service
 sed -i 's/startlxde/startxfce4/g' /etc/lxdm/Xsession
 sed -i 's/# session/session/g' /etc/lxdm/lxdm.conf
 sed -i 's/startlxde/startxfce4/g' /etc/lxdm/lxdm.conf
 echo -e \"\n Modificiram desktop ikone Xfce4 DE-a...\"
 echo -e \"style \\\"xfdesktop-icon-view\\\" {\n\tXfdesktopIconView::label-alpha = 0
	XfdesktopIconView::shadow-x-offset = 1\n\tXfdesktopIconView::shadow-y-offset = 1
	XfdesktopIconView::shadow-color = \\\"#000000\\\"\n\tXfdesktopIconView::selected-shadow-x-offset = 0
	XfdesktopIconView::selected-shadow-y-offset = 0\n\tXfdesktopIconView::selected-shadow-color = \\\"#000000\\\"
	fg[NORMAL] = \\\"#ffffff\\\"\n\tfg[SELECTED] = \\\"#ffffff\\\"\n\tfg[ACTIVE] = \\\"#ffffff\\\" }
	widget_class \\\"*XfdesktopIconView*\\\" style \\\"xfdesktop-icon-view\\\"\" >> /home/$Korisnik/.gtkrc-2.0
 echo -e \"exec startxfce4\" >> /home/$Korisnik/.xinitrc
;;
l*)
 echo -e \"\n Pokrećem instalaciju LXDE-a...\"
 pacman -Sy --noconfirm galculator gnome-mplayer leafpad lxde lxdm obconf xarchiver vlc zenity
 if [ \$? != 0 ]; then
  echo -e \"\n $Error *\n\n Pritisnite Enter za nastavak...\n Press Enter to continue...\n\n\"
  read -p \"\"
 fi
 systemctl enable lxdm.service
 echo -e \"exec startlxde\" >> /home/$Korisnik/.xinitrc
;;
*)
 echo -e \"\n \e[1;36mINFO:\e[31m $DEinstNotSel!\e[0m\"
;;
esac
case \"$NumLock\" in
d*)
 echo -e \"\n Uključujem numlock pri logiranju...\"
 if [ -e /usr/share/config/kdm/kdmrc ]; then
  sed -i 's/#NumLock=Off/NumLock=On/g' /usr/share/config/kdm/kdmrc
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
echo -e \"\n Dodajem boju za ls i grep naredbe...\"
echo -e \"alias ls='ls --color=auto'\nalias grep='grep --color=auto'\" >> /home/$Korisnik/.bashrc
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
d*|y*|\"\")
 echo -e \"\n Postavljam auto-login...\"
 if [ -e /usr/share/config/kdm/kdmrc ]; then
  sed -i 's/#AutoLoginUser=fred/AutoLoginUser=$Korisnik/g' /usr/share/config/kdm/kdmrc
  sed -i 's/#AutoLoginEnable/AutoLoginEnable/g' /usr/share/config/kdm/kdmrc
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
echo -e \"\n Konfiguracija GRUB bootloadera...\"
grub-mkconfig -o /boot/grub/grub.cfg
rm -f /root/.bashrc
rm -f /etc/ArchChroot" > /mnt/etc/ArchChroot
#==================================================================================================#
echo -e "sh /etc/ArchChroot\nexit" > /mnt/root/.bashrc
arch-chroot /mnt /bin/bash
clear
echo -e "\n Odmontiravanje montiranih particija..."
umount -R /mnt
swapoff -a
echo -e "\n\e[36m*********************************\n*\t\e[37m$InstallEnd\e[36m\t*\n*********************************\e[0m\n\n $EnjoyWith \e[1;36mArch Linux \e[1;33m:)\e[0m\n"
#read \?" $EnterTo reboot..."
sleep 5 | echo -e " \nReboot za 5 sekundi... \nRebooting in 5 seconds..."
reboot
