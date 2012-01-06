#!/bin/bash
# This script cleans, configures and compiles the kernel, and creates a uImage from an initramfs and the kernel.
# Originally written by Boden Matthews for use in the TouchPadBuntu project, feel free to take this script and edit it to your needs.
make ARCH=arm CROSS_COMPILE=arm-none-eabi- clean
make ARCH=arm CROSS_COMPILE=arm-none-eabi- mrproper
make ARCH=arm CROSS_COMPILE=arm-none-eabi- tenderloin_defconfig
make ARCH=arm CROSS_COMPILE=arm-none-eabi- menuconfig
make ARCH=arm CROSS_COMPILE=arm-none-eabi- uImage -j5
mkimage -A arm -O linux -T ramdisk -C none -a 0x60000000 -e 0x60000000 -n "Image" -d ./initramfs.cpio.gz arch/arm/boot/uRamdisk
mkdir modpack
make ARCH=arm CROSS_COMPILE=arm-none-eabi- modules -j5
make INSTALL_MOD_PATH=modpack ARCH=arm CROSS_COMPILE=arm-none-eabi- modules_install
mkimage -A arm -O linux -T ramdisk -C none -a 0x60000000 -e 0x60000000 -n "Image" -d ./initramfs.cpio.gz arch/arm/boot/uRamdisk
mkimage -A arm -O linux -T multi -a 0x40208000 -e 0x40208000 -C none -n "multi image" -d arch/arm/boot/uImage:arch/arm/boot/uRamdisk uImage.TouchPadBuntu
tar czf ALARM-modpack.tar.gz modpack/lib
