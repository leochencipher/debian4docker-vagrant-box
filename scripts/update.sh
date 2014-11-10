#!/bin/bash -eux

apt-get update
apt-get -y upgrade

# ensure the correct kernel headers are installed
apt-get -y install linux-headers-$(uname -r)

# update package index on boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# install curl to fix broken wget while retrieving content from secured sites
apt-get -y install curl

# install rsync
apt-get -y install rsync

# install make
apt-get -y install make

#
# install tools build small images
#  @see https://github.com/unclejack/debian2docker/blob/master/Dockerfile
#
apt-get -y install busybox-static adduser bzip2 xz-utils nano insserv kmod sudo debootstrap cpio isolinux syslinux xorriso
