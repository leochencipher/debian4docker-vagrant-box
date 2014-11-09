#!/bin/bash -eux

#
# Cleans old box
#
rm -f *.box

#
# Launchs the build
#
packer build debian.json