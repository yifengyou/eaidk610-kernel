#!/bin/bash

set -e

export PATH=`realpath ../gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/`:$PATH
echo $PATH

CURRENTDIR=`pwd`
echo "CURRENTDIR: ${CURRENTDIR}"
BUILDDIR=${CURRENTDIR}
echo "BUILDDIR: ${BUILDDIR}"
exec > >(tee ${BUILDDIR}/log.eaidk-linux.log) 2>&1

echo    "******************************"
echo    "*     Make dtb               *"
echo    "******************************"
rm -f arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux.dtb
make Q= ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip/rk3399-eaidk-linux.dtb
echo "-> make rk3399-eaidk-linux.dtb done!"

rm -f arch/arm64/boot/dts/rockchip/rk3399-eaidk-android.dtb
make Q= V=1 ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip/rk3399-eaidk-android.dtb
echo "-> make rk3399-eaidk-android.dtb done!"

echo "All done! Bye~"
