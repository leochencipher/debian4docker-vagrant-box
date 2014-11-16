#!/bin/sh

echo
echo "-------------------------------------"
echo " Cleanup all unused packages"
echo "-------------------------------------"
#
# @see https://wiki.debian.org/ReduceDebian#Reducing_the_size_of_the_Debian_Installation_Footprint
# @see https://github.com/ffuenf/vagrant-boxes/
#

#
# Removes development packages
#
echo " --> All *-dev packages cleanup"
dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y --force-yes purge

#
# Linux cleanup
#
echo " --> Linux cleanup (image, header, source)"
apt-get -y --force-yes purge $(dpkg --list |grep '^rc' |awk '{print $2}')
apt-get -y --force-yes purge $(dpkg --list |egrep 'linux-image-[0-9]' |awk '{print $3,$2}' |sort -nr |tail -n +2 |grep -v $(uname -r) |awk '{ print $2}')
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y --force-yes purge
dpkg --list | awk '{ print $2 }' | grep linux-headers | xargs apt-get -y --force-yes purge

#
# Removing unused packages
#
#   Doing the job like this because put all the list in a single apt command will fail
#   with the first non present package...
#
for PACKAGE in build-essential \
				cpp \
				gcc \
				g++ \
				aptitude \
				aptitude-common \
				libicu52 \
				git \
				libgtk2.0-common \
				geoip-database \
				binutils \
				mutt \
				text \
				xkb-data \
				libxapian22 \
				w3m \
				libgcc-4.9-dev \
				cpp-4.9 \
				libglib2.0-0 \
				debian-faq \
				hicolor-icon-theme \
				fonts-dejavu-core \
				groff-base \
				texinfo \
				guile-2.0-libs \
				libgdk-pixbuf2.0-common \
				doc-debian-fr \
				libx11-data \
				xauth \
				libxmuu1 \
				libxcb1 \
				libx11-6 \
				libxext6 \
				ppp \
				pppconfig \
				pppoeconf \
				man-db \
				manpages \
				info \
				popularity-contest \
				python \
				python2.7 \
				libpython2.7-stdlib \
				docutils-doc \
				debconf-i18n \
				ispell \
				nfs-common \
				libnfsidmap2 \
				keyboard-configuration \
				laptop-detect \
				tasksel \
				exim4-daemon-light \
				bind9-host \
				dnsutils \
				libxml2 \
				at

do
	if ! apt-get --yes --force-yes purge  "${PACKAGE}"
	then
		echo "WARNING: ${PACKAGE} isn't installed"
	fi
done

#
# Final apt clean
#
echo " --> Final package cleanup"
apt-get -y --force-yes --purge autoremove
apt-get -y clean
