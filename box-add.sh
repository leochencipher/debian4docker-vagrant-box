#!/bin/sh -e

echo
echo "=============================================="
echo " Adding debian box to your vagrant system"
echo "=============================================="

vagrant box add debian4docker_virtualbox.box --name=AlbanMontaigu/debian4docker --force
