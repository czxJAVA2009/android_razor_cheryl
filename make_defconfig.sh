#!/bin/bash

DEFCONFIG_FILE="cheryl_defconfig"
KERNEL_DIR=$(pwd)
TOOLCHAIN=$KERNEL_DIR/arm64-tc
export CROSS_COMPILE=$TOOLCHAIN/bin/aarch64-linux-android-

if [ -z "$DEFCONFIG_FILE" ]; then
	echo "Need defconfig file(xxx_defconfig)!"
	exit -1
fi

if [ ! -e arch/arm64/configs/$DEFCONFIG_FILE ]; then
	echo "No such file : arch/arm64/configs/$DEFCONFIG_FILE"
	exit -1
fi

# make .config
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm64 ${DEFCONFIG_FILE}

# run menuconfig
env KCONFIG_NOTIMESTAMP=true \
make menuconfig ARCH=arm64

# copy .config to defconfig
mv .config arch/arm64/configs/${DEFCONFIG_FILE}
# clean kernel object
make mrproper
