#!/bin/bash -eux

#--------------------------------------------------------------------------------------
# DOCKER INSTALLER
#
#  @see https://github.com/ffuenf/vagrant-boxes/blob/master/packer/scripts/docker.sh
#  @see https://docs.docker.com/installation/debian/
#--------------------------------------------------------------------------------------

#
# enable memory and swap cgroup
#
perl -p -i -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g'  /etc/default/grub
/usr/sbin/update-grub

#
# Install Kernel 3.14 from wheezy-backports
#
echo "deb http://http.debian.net/debian wheezy-backports main" > /etc/apt/sources.list.d/docker.list
apt-get update -qq
apt-get install -q -y --force-yes -t wheezy-backports linux-image-amd64

#
# Install Docker using the get.docker.com script
#
curl -sSL https://get.docker.com/ | sh

#
# Add the docker group if it doesn't already exist.
#
groupadd docker

#
# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
#
gpasswd -a ${USER} docker

#
# Restart the Docker daemon
#
service docker restart
