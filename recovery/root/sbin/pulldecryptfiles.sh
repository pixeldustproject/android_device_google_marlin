#!/sbin/sh

# This pulls the files out of /vendor that are needed for decrypt
# This allows us to decrypt the device in recovery and still be
# able to unmount /vendor when we are done.

SLOT=$(getprop ro.boot.slot_suffix)


if [ "`mount|grep "/dev/block/bootdevice/by-name/system${SLOT} on /system_root"`" == "" ];then
        mount -o rw,remount rootfs /
        mkdir /system_root
        mount -t ext4 -o ro /dev/block/bootdevice/by-name/system$SLOT /system_root
else    
        exit
fi

if [ "`mount|grep "/dev/block/bootdevice/by-name/system${SLOT} on /system "`" == "" ];then
	mkdir -p /system
        mount -o bind /system_root/system /system
	mkdir /tmp/system
	cp -r /system/lib64 /tmp/system/
	cp -r /system/bin /tmp/system/
	umount /system
	umount /system_root
	mkdir /system/lib64
	mkdir /system/bin
	mv /tmp/system/lib64/* /system/lib64/
	mv /tmp/system/bin/* /system/bin/
	rmdir /tmp/system/lib64 /tmp/system/bin /tmp/system
fi

if [ "`mount|grep "/dev/block/bootdevice/by-name/userdata on /data"`" == "" ];then
	LD_LIBRARY_PATH=/system/lib64 /system/bin/e2fsck  -y -E journal_only /dev/block/bootdevice/by-name/userdata
        LD_LIBRARY_PATH=/system/lib64 /system/bin/tune2fs -Q ^usrquota,^grpquota,^prjquota /dev/block/bootdevice/by-name/userdata
        mount /dev/block/bootdevice/by-name/userdata /data
fi

if [ "`mount|grep "/dev/block/bootdevice/by-name/vendor${SLOT} on /vendor"`" == "" ];then
	mkdir -p /vendor
	mkdir -p /tmp/vendor
        mount -t ext4 -o ro /dev/block/bootdevice/by-name/vendor_a /vendor

	cp -r /vendor/lib64 /tmp/vendor/
	cp -r /vendor/bin /tmp/vendor/

	umount /vendor

	mv /tmp/vendor/* /vendor/
	rmdir /tmp/vendor
fi


setprop pulldecryptfiles.finished 1
exit 0
