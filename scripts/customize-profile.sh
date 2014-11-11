#!/bin/sh -e

#--------------------------------------------------------------------------------------
# CUSTOMIZE PROFILE TO MAKE IT MORE FANCY
#--------------------------------------------------------------------------------------

PROFILE_FILES=("/home/vagrant/.bashrc" "/home/docker/.bashrc")

#
# For each profile, do the work
#
for PROFILE_FILE in ${PROFILE_FILES[@]}; do
	echo "Customizing $PROFILE_FILE"
	echo " --> Enabling color prompt"
	sed -ri 's/#force_color_prompt=yes/force_color_prompt=yes/' $PROFILE_FILE

	echo " --> Enabling all alias"
	sed -ri 's/#alias/alias/' $PROFILE_FILE
done
