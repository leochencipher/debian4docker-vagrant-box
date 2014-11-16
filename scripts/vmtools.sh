#!/bin/sh -e

echo "#---------------------------------------------------------------------------------------------------"
echo "# Installing vm tools (i.e. virtualbox guest additions)"
echo "#---------------------------------------------------------------------------------------------------"

case "$PACKER_BUILDER_TYPE" in 

virtualbox-iso|virtualbox-ovf) 
    mkdir /tmp/vbox
    VER=$(cat /home/vagrant/.vbox_version)
    mount -o loop /home/vagrant/VBoxGuestAdditions_$VER.iso /tmp/vbox 
    sh /tmp/vbox/VBoxLinuxAdditions.run
    umount /tmp/vbox
    rmdir /tmp/vbox
    rm /home/vagrant/*.iso
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
    
    # Disable vbox video module since its not wanted
    sed -ri 's/(running_vboxvideo \|\| \$MODPROBE vboxvideo)/#\1/' /etc/init.d/vboxadd
    echo "blacklist vboxvideo" > /etc/modprobe.d/vboxvideo.conf
    update-initramfs -u -k all
    update-grub
    ;;

*)
    echo "Unknown Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected."
    echo "Known are virtualbox-ovf."
    ;;

esac
