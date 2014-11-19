#!/bin/sh

echo
echo "-------------------------------------"
echo " Customizing profiles"
echo "-------------------------------------"

PROFILES=("/home/vagrant")

#
# For each profile, do the work
#
for PROFILE_FILE in ${PROFILES[@]}; do
	echo "Customizing $PROFILES"
	echo " --> Enabling color prompt"
	sed -ri 's/#force_color_prompt=yes/force_color_prompt=yes/' $PROFILES/.bashrc

	echo " --> Enabling all alias"
	sed -ri 's/#alias/alias/' $PROFILES

	#
	# Custom docker aliases
	#
	#  @see http://www.calazan.com/docker-cleanup-commands/
	#
	echo " --> Adding custom docker aliases"
	cat <<EOT >> $PROFILES/.bash_aliases
# ~/.bash_aliases

# Kill all running containers.
alias docker-killa='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias docker-cleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias docker-cleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias docker-clean='docker-cleanc || true && docker-cleani'
EOT

done
