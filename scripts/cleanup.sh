#!/bin/sh


# ---------------------------------------------------------------------------------------------------
# Global system cleanup to reduce fooprint
#
#  @see https://wiki.debian.org/ReduceDebian#Reducing_the_size_of_the_Debian_Installation_Footprint
#  @see https://github.com/ffuenf/vagrant-boxes/
# ---------------------------------------------------------------------------------------------------

#
# Delete development packages
#
echo " --> Dev packages cleanup"
dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y --force-yes purge
apt-get -y --force-yes purge cpp gcc g++

# 
# Delete X11 libraries
#
echo " --> X11 libraries cleanup"
apt-get -y --force-yes purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6

#
# Delete obsolete networking
#
echo " --> Obsolete networking cleanup"
apt-get -y --force-yes purge ppp pppconfig pppoeconf

#
# Delete oddities
#
echo " --> Oddies cleanup"
apt-get -y --force-yes purge popularity-contest

#
# Cleanup Virtualbox
#
echo " --> Virtualbox cleanup"
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?

#
# Removing dictionnaries
#
echo " --> Dictionnaries cleanup"
apt-get -y --force-yes purge aspell ispell

#
# Removing man etc
# 
echo " --> Man doc info cleanup"
apt-get -y --force-yes purge man-db manpages info

#
# Cleanup unused files
#
echo " --> Unused files cleanup"
rm -f /usr/bin/omshell
rm -f /var/cache/debconf/templates.dat
rm -f /var/cache/debconf/templates.dat-old
rm -f /usr/bin/openssl
rm -f /usr/sbin/visudo
rm -f /usr/bin/oldfind
rm -rf /usr/share/mime/*
rm -rf /usr/share/X11/*
rm -rf /usr/share/fonts/*
rm -f /var/lib/dpkg/info/linux-image*-amd64.md5sums
rm -f /var/lib/apt/lists/*

#
# Remove unused locales
#
echo " --> Removing unused locales"
rm -rf /usr/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU,en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fur,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ja,ka,kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl,ps,pt,pt_BR,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur,urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu}

#
# Remove docs
#
echo " --> Removing docs"
rm -rf /usr/share/doc

#
# Remove files from cache
#
echo " --> Removing cache"
find /var/cache -type f -delete -print

#
# Remove guest addition source
#
echo " --> Removing Virtualbox guest addtions source"
rm -rf /usr/src/virtualbox-ose-guest*
rm -rf /usr/src/vboxguest*

#
# Remove foreign man pages
#
echo " --> Removing foreign language man files"
rm -rf /usr/share/man/??
rm -rf /usr/share/man/??_*

#
# Remove non-critical packages
#
echo " --> Removing non non-critical package"
apt-get -y --force-yes purge $(aptitude search '~i!~M!~prequired!~pimportant!~R~prequired!~R~R~prequired!~R~pimportant!~R~R~pimportant!busybox!grub!initramfs-tools' | awk '{print $2}')
apt-get -y --force-yes purge aptitude aptitude-common libicu52 git libgtk2.0-common geoip-database binutils mutt ifrench-gut doc-linux-fr-text xkb-data

#
# Linux cleanup
#
echo " --> Linux cleanup (image, header, source)"
apt-get -y --force-yes purge build-essential
apt-get -y --force-yes purge $(dpkg --list |grep '^rc' |awk '{print $2}')
apt-get -y --force-yes purge $(dpkg --list |egrep 'linux-image-[0-9]' |awk '{print $3,$2}' |sort -nr |tail -n +2 |grep -v $(uname -r) |awk '{ print $2}')
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y --force-yes purge
dpkg --list | awk '{ print $2 }' | grep linux-headers | xargs apt-get -y --force-yes purge

#
# Clean all unrequested deps
#
echo " --> Apt global purge and autoremove"
apt-get -y --force-yes --purge autoremove
apt-get -y clean

#
# Removing unused files
#
echo " --> Removing unused files"
find / -name *~ | xargs rm -f

#
# Truncating logs
#
echo " --> Truncating all logs"
for FILE in $(find /var/log/ -type f)
do
: > ${FILE}
done

#
# Remove history file
#
echo " --> Remove history files"
unset HISTFILE
rm -f ~/.bash_history /home/vagrant/.bash_history
