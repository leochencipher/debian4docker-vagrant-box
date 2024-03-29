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
apt-get -y install make vim

#
# Setting max systemd journal size
#  @see https://bbs.archlinux.org/viewtopic.php?id=158510
SYSTEMD_JOURNAL_CONF_FILE="/etc/systemd/journald.conf"
sed -ri 's/#SystemMaxUse=.*/SystemMaxUse=10M/' $SYSTEMD_JOURNAL_CONF_FILE
sed -ri 's/#ForwardToSyslog=.*/ForwardToSyslog=no/' $SYSTEMD_JOURNAL_CONF_FILE

#
# Remove 5s grub timeout to speed up booting
#  @see https://github.com/pjkundert/cpppo/blob/master/packer/debian-8-amd64/scripts/base.sh
#
echo " --> Remove 5s grub timeout to speed up booting"
sed -ri 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub

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

#
# Reducing reserved space for the root
#  @see http://forums.debian.net/viewtopic.php?f=16&t=111588#p529834
#  @see http://www.microhowto.info/howto/reduce_the_space_reserved_for_root_on_an_ext2_ext3_or_ext4_filesystem.html
#
echo " --> Reducing reserved space for the root"
tune2fs -m 1 /dev/sda1
tune2fs -m 1 /dev/mapper/debian4docker--vg-root

#
# Setting /var/log to tmps
#  @see http://forums.debian.net/viewtopic.php?f=16&t=111588#p529834
#
echo "tmpfs /var/log/ tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0755,size=20m 0 0" >> /etc/fstab

#
# Settings custom logo for connection
#
cat <<EOT >> /etc/modtd
                        ##        .
                  ## ## ##       ==
               ## ## ## ##      ===
           /""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
           \______ o          __/
             \    \        __/
              \____\______/
     _      _     _               ___     _            _             
    | |    | |   (_)             /   |   | |          | |            
  __| | ___| |__  _  __ _ _ __  / /| | __| | ___   ___| | _____ _ __ 
 / _\` |/ _ | '_ \| |/ _\` | '_ \/ /_| |/ _\` |/ _ \ / __| |/ / _ | '__|
| (_| |  __| |_) | | (_| | | | \___  | (_| | (_) | (__|   |  __| |   
 \__,_|\___|_.__/|_|\__,_|_| |_|   |_/\__,_|\___/ \___|_|\_\___|_|   

                                   docker 1.3.1, fig 1.0.1, make 4.0
EOT
