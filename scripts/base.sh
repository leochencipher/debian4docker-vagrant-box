#!/bin/sh

echo
echo "-------------------------------------"
echo " Base system preparation"
echo "-------------------------------------"

#
# Updating system
#
echo " --> Updating system"
apt-get update
apt-get -y upgrade

#
# ensure the correct kernel headers are installed
#
echo " --> Ensure the correct kernel headers are installed"
apt-get -y install linux-headers-$(uname -r)

#
# uncoment it if you want update package index on boot
# (may be slow...)
#
#cat <<EOF > /etc/init/refresh-apt.conf
#description "update package index"
#start on networking
#task
#exec /usr/bin/apt-get update
#EOF

#
# Installing usefull tools
#
echo " --> Installing usefull tools"
apt-get -y install make

#
# Remove 5s grub timeout to speed up booting
#  @see https://github.com/pjkundert/cpppo/blob/master/packer/debian-8-amd64/scripts/base.sh
#
echo " --> Remove 5s grub timeout to speed up booting"
sed -ri 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
/usr/sbin/update-grub


#
# Disable unwanted kernel modules
#
echo " --> Disable unwanted kernel modules"

# Fix dmesg "vapiix4_smbus 0000:00:07.0: SMBus base address uninitialized - upgrade BIOS or use force_addr=0xaddr"
#  @see http://askubuntu.com/questions/298290/smbus-bios-error-while-booting-ubuntu-in-virtualbox
echo "blacklist i2c_piix4" > /etc/modprobe.d/i2c_piix4.conf

# Fix dmesg "intel_rapl: no valid rapl domains found in package 0"
echo "blacklist intel_rapl" > /etc/modprobe.d/intel_rapl.conf

#
# Kernel and grub update
#
update-initramfs -u -k all
update-grub
