#!/bin/bash -eux

#-------------------------------------------------------------------------------------
# @See https://github.com/unclejack/debian2docker/blob/master/hooks/clean.chroot
#-------------------------------------------------------------------------------------
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
rm -rf /var/lib/apt/lists/* 
rm -f /var/cache/apt/*.bin


#-------------------------------------------------------------------------------------
# @see https://github.com/unclejack/debian2docker/blob/master/hooks/stripped.chroot
#-------------------------------------------------------------------------------------

# Removing unused packages
for PACKAGE in apt-utils aptitude man-db manpages info wget dselect
do
if ! apt-get remove --purge --yes "${PACKAGE}"
then
echo "WARNING: ${PACKAGE} isn't installed"
fi
done
apt-get autoremove --yes || true
# Removing unused files
find . -name *~ | xargs rm -f
rm -rf /usr/include/*
#rm -rf /usr/share/groff/*
rm -rf /usr/share/doc/*
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /usr/share/i18n/*
rm -rf /usr/share/info/*
rm -rf /usr/share/lintian/*
rm -rf /usr/share/linda/*
rm -rf /usr/share/zoneinfo/*
rm -rf /var/cache/man/*
# Truncating logs
for FILE in $(find /var/log/ -type f)
do
: > ${FILE}
done


#-------------------------------------------------------------------------------------
# @see https://github.com/unclejack/debian2docker/blob/master/hooks/zz-final.chroot
#-------------------------------------------------------------------------------------
dpkg --force-all -P debian-archive-keyring busybox live-tools apt file debconf-i18n klibc-utils libklibc initramfs-tools cpio gcc-4.7-base:amd64
rm -rf /usr/share/file
rm -rf /usr/share/zoneinfo
rm -rf /var/lib/dpkg
rm -rf /usr/lib/locale
rm -f /usr/bin/gpg
rm -f /usr/bin/gpgv
rm -f /sbin/ldconfig.real
rm -rf /usr/lib/x86_64-linux-gnu/gconv
rm -rf /usr/lib/x86_64-linux-gnu/libdb*.so
rm -rf /usr/lib/x86_64-linux-gnu/libapt*.so.*
rm -rf /usr/lib/x86_64-linux-gnu/libapt*.so
rm -rf /usr/lib/libperl*.so*
rm -rf /lib/modules/3.13-1-amd64/modules.alias
rm -rf /usr/lib/apt
rm -rf /var/lib/initramfs-tools
rm -rf /usr/share/perl
rm -rf /usr/bin/dpkg*
rm -rf /var/log/apt
