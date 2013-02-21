#!/bin/sh

echo 'Generating moboot compatible uImage...'

mkimage -A arm -O linux -T multi -C none -a 0x40208000 -e 0x40208000 -n "multi image" -d arch/arm/boot/uImage:uRamdisk uImage.Ubuntu13

