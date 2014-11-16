#!/bin/sh

echo
echo "-------------------------------------"
echo " Cleanup all unused files"
echo "-------------------------------------"
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
rm -f /usr/sbin/visudo
rm -f /usr/bin/oldfind
rm -rf /usr/share/mime/*
rm -rf /usr/share/X11/*
rm -rf /usr/share/fonts/*
rm -f /var/lib/dpkg/info/linux-image*-amd64.md5sums
rm -f /var/lib/apt/lists/*
rm -f /var/lib/apt/lists/partial/*

#
# Unused locales cleanup
#
echo " --> Unused locales cleanup"
find /usr/share/locale/* ! -name en_US -delete -print
find /usr/share/i18n/locales/* ! -name en_US ! -name C -delete -print
find /usr/share/i18n/charmaps/* ! -name UTF-8.gz ! -name ANSI* -delete -print

#
# Unused zoneinfo cleanup
#
echo " --> Unused zoneinfo cleanup"
find /usr/share/zoneinfo/* ! -name localtime ! -name CET ! -name UTC ! -name zone.tab ! -name Paris -delete -print

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
rm -rf /opt/VBoxGuestAdditions-*/src

#
# Manpages files cleanup
#
echo " --> Manpages files cleanup"
rm -rf /usr/share/man

#
# All ~* files cleanup
#
echo " --> All ~* files cleanup"
find / -name *~ -delete -print

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
