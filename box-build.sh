#!/bin/bash -eux

#
# Cleans old box
#
rm -f *.box
rm -rf output-virtualbox-iso 
#rm -rf packer_cache

#
# Launchs the build
#
packer build debian.json
