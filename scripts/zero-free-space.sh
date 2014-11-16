#!/bin/sh

echo
echo "-----------------------------------------------------------------"
echo " Zeroing out the free space to save space in the final image"
echo "-----------------------------------------------------------------"

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

dd if=/dev/zero of=/boot/EMPTY bs=1M
rm -f /boot/EMPTY

#
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
#
sync
