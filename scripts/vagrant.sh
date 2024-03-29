#!/bin/sh

echo
echo "-------------------------------------"
echo " Tunning vagrant configuration"
echo "-------------------------------------"

mkdir -p /home/vagrant/.ssh
curl -L -k --progress-bar 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -o /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh