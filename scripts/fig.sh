#!/bin/bash -eux

#
# install Fig
# @see http://www.fig.sh/install.html
# @https://github.com/AlbanMontaigu/docker-enabled-vagrant/blob/master/debian-jessie/vagrant-provision.sh
#
curl -o fig -L https://github.com/docker/fig/releases/download/1.0.0/fig-`uname -s`-`uname -m`
chmod a+x fig
sudo mv fig /usr/local/bin
