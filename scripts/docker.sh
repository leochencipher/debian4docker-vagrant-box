#!/bin/bash -eux

#--------------------------------------------------------------------------------------
# DOCKER INSTALLER
#
#  @see https://github.com/ffuenf/vagrant-boxes/blob/master/packer/scripts/docker.sh
#  @see https://docs.docker.com/installation/debian/
#--------------------------------------------------------------------------------------

#
# Install Kernel 3.14 from wheezy-backports
#
echo " --> Updating Kernel from backport to enable docker install"
echo "deb http://http.debian.net/debian wheezy-backports main" > /etc/apt/sources.list.d/docker.list
apt-get update -qq
apt-get install -q -y --force-yes -t wheezy-backports linux-image-amd64

#
# Install Docker using the get.docker.com script
#
echo " --> Installing docker"
curl -sSL https://get.docker.com/ | sh

#
# Add the docker group if it doesn't already exist.
#
echo " --> Updating docker group"
groupadd docker

#
# Add the connected user "${USER}" to the docker group.
# Change the user name to match your preferred user.
# You may have to logout and log back in again for
# this to take effect.
#
gpasswd -a ${USER} docker


#
# Solves AUFS layers limitation
#
echo " --> Switching from aufs to devicemapper to solve layers limitation"

DOCKER_CONFIGURATION_FILE="/etc/default/docker"

if grep -q devicemapper $DOCKER_CONFIGURATION_FILE; then
    echo " --> $DOCKER_CONFIGURATION_FILE nothing todo !"
else
    sed -i 's/#DOCKER_OPTS=".*"/DOCKER_OPTS="--storage-driver=devicemapper"/' $DOCKER_CONFIGURATION_FILE
    echo " --> $DOCKER_CONFIGURATION_FILE updated !"
fi

#
# Restart the Docker daemon
#
echo " --> Restarting docker"
service docker restart


#
# enable memory and swap cgroup to avoid docker complains
#  @see https://meta.discourse.org/t/fix-for-warning-no-swap-limit-support-error-when-bootstrapping-discourse/16622
#
echo " --> Solving swap limit warning"
sed -ri 's/GRUB_CMDLINE_LINUX="(.*)"/GRUB_CMDLINE_LINUX="\1 cgroup_enable=memory swapaccount=1"/' /etc/default/grub
/usr/sbin/update-grub
