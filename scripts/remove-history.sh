#!/bin/sh -e

# Remove history file
unset HISTFILE
rm ~/.bash_history /home/vagrant/.bash_history

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync
