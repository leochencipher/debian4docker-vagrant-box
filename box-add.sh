#!/bin/sh -e

echo "#==================================================================================================="
echo "# Adding debian box to your vagrant system"
echo "#==================================================================================================="

vagrant box add debian_virtualbox.box --name=AlbanMontaigu/debian --force
