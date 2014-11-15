#!/bin/sh

echo "#---------------------------------------------------------------------------------------------------"
echo "# Cleanup all unused files"
echo "#---------------------------------------------------------------------------------------------------"
#
# @see https://wiki.debian.org/ReduceDebian#Reducing_the_size_of_the_Debian_Installation_Footprint
# @see https://github.com/ffuenf/vagrant-boxes/
#

#
# Misc unused files cleanup
#
echo " --> Misc unused files cleanup"
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
# Unused locales cleanup
#   Multiple times because one time will be too long
#
echo " --> Unused locales cleanup"
rm -rf /usr/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU}
rm -rf /usr/share/locale/{en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fur,fr,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ja,ka}
rm -rf /usr/share/locale/{kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl}
rm -rf /usr/share/locale/{ps,pt,pt_BR,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur}
rm -rf /usr/share/locale/{urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu}

#
# Docs cleanup
#
echo " --> Docs cleanup"
rm -rf /usr/share/doc

#
# Cache cleanup
#
echo " --> Cache cleanup"
find /var/cache -type f -delete -print

#
# Virtualbox guest addition source and install files cleanup
#
echo " --> Virtualbox guest addition source and install files cleanup"
rm -rf /usr/src/virtualbox-ose-guest*
rm -rf /usr/src/vboxguest*
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?

#
# Manpages files cleanup
#
echo " --> Manpages files cleanup"
rm -rf /usr/share/man/??
rm -rf /usr/share/man/??_*

#
# All ~* files cleanup
#
echo " --> All ~* files cleanup"
find / -name *~ | xargs rm -f

#
# Logs (truncate) cleanup
#
echo " --> Logs (truncate) cleanup"
for FILE in $(find /var/log/ -type f)
do
: > ${FILE}
done

#
# History files cleanup
#
echo " --> History files cleanup"
unset HISTFILE
rm -f ~/.bash_history /home/vagrant/.bash_history
