#!/bin/sh

echo
echo "-------------------------------------"
echo " Global kernel clean"
echo "-------------------------------------"
#
# @see https://github.com/unclejack/debian2docker/blob/master/hooks/kernelclean.chroot
#

rm -rf /lib/modules/*/kernel/sound/*
rm -rf /lib/modules/*/kernel/drivers/infiniband/*
rm -rf /lib/modules/*/kernel/drivers/gpu/*
rm -rf /lib/modules/*/kernel/drivers/isdn/*
rm -rf /lib/modules/*/kernel/drivers/media/*
rm -rf /lib/modules/*/kernel/drivers/staging/*
rm -rf /lib/modules/*/kernel/fs/ocfs2/*
rm -rf /lib/modules/*/kernel/fs/ntfs/*
rm -rf /lib/modules/*/kernel/fs/cifs/*
rm -rf /lib/modules/*/kernel/fs/ubifs/*
rm -rf /lib/modules/*/kernel/fs/reiserfs/*
rm -rf /lib/modules/*/kernel/fs/jffs2/*
rm -rf /lib/modules/*/kernel/fs/hfsplus/*
rm -rf /lib/modules/*/kernel/fs/gfs2/*
rm -rf /lib/modules/*/kernel/fs/nfs/*
rm -rf /lib/modules/*/kernel/fs/btrfs/*
rm -rf /lib/modules/*/kernel/fs/xfs/*
rm -rf /lib/modules/*/kernel/fs/nls/*
rm -rf /lib/modules/*/kernel/drivers/net/mac80211/*
rm -rf /lib/modules/*/kernel/drivers/net/wireless/*
rm -rf /lib/modules/*/kernel/drivers/net/wimax/*
rm -rf /lib/modules/*/kernel/drivers/net/irda/*
rm -rf /lib/modules/*/kernel/drivers/net/hamradio/*
rm -rf /lib/modules/*/kernel/drivers/net/arcnet/*
rm -rf /lib/modules/*/kernel/drivers/net/can/*
rm -rf /lib/modules/*/kernel/drivers/net/ethernet/qlogic/*
rm -rf /lib/modules/*/kernel/drivers/net/ethernet/mellanox/*
rm -rf /lib/modules/*/kernel/drivers/net/ethernet/broadcom/*
rm -rf /lib/modules/*/kernel/drivers/scsi/bfa/*
rm -rf /lib/modules/*/kernel/arch/x86/kvm/*
rm -rf /lib/modules/*/kernel/net/wireless/*
rm -rf /lib/modules/*/kernel/net/mac80211/*
rm -rf /lib/modules/*/kernel/net/sunrpc/*
rm -rf /lib/modules/*/kernel/net/bluetooth/*
rm -rf /lib/modules/*/kernel/net/irda/*

for i in `ls /lib/modules/`;
do
	depmod $i
done