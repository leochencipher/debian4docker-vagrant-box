#!/bin/sh -e

#--------------------------------------------------------------------------------------
# DOCKER INSTALLER
#
#  @see https://github.com/ffuenf/vagrant-boxes/blob/master/packer/scripts/docker.sh
#  @see https://docs.docker.com/installation/debian/
#--------------------------------------------------------------------------------------

#
# Install Docker using the get.docker.com script
#
echo " --> Installing docker"
apt-get update -qq
apt-get install -q -y --force-yes docker.io

#
# To avoid remove during cleanup
#
apt-mark hold docker.io

#
# Add the right to vagrant user to enable docker
#
echo " --> Adding docker rights to vagrant user"
usermod -a -G docker vagrant

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
GRUB_CONFIGURATION_FILE="/etc/default/grub"

if grep -q swapaccount $GRUB_CONFIGURATION_FILE; then
	echo " --> Limit warning already solved !"
else
	echo " --> Solving swap limit warning"
	sed -ri 's/GRUB_CMDLINE_LINUX="(.*)"/GRUB_CMDLINE_LINUX="\1 cgroup_enable=memory swapaccount=1"/' $GRUB_CONFIGURATION_FILE
	/usr/sbin/update-grub
fi
