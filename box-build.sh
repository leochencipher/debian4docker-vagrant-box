#!/bin/sh -e

echo
echo "=================================="
echo " Debian box build"
echo "=================================="

#
# Cleans old box
#
echo " --> Cleaning old build files"
rm -f *.box
rm -rf output-virtualbox-iso 
#rm -rf packer_cache

#
# Configuration of box param
#
echo " --> configuring environment variables"
export PACKER_OS_TYPE="Debian_64"
export PACKER_BOX_NAME="debian4docker"
export PACKER_ISO_BASE_URL="http://cdimage.debian.org/cdimage/daily-builds/daily/current/amd64/iso-cd"
export PACKER_ISO_URL="${PACKER_ISO_BASE_URL}/debian-testing-amd64-netinst.iso"

#
# Getting checksum because it changes daily...
#
echo " --> Getting and configuring ISO checksum"
export PACKER_ISO_CHECKSUM=$(curl --progress-bar -L $PACKER_ISO_BASE_URL/SHA512SUMS.small | awk '{ print $1 }')

#
# Launchs the build
#
packer build debian4docker.json
