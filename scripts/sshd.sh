#!/bin/sh

echo
echo "-------------------------------------"
echo " Tunning sshd"
echo "-------------------------------------"

echo "UseDNS no" >> /etc/ssh/sshd_config
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
