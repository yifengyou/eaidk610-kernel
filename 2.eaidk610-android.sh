#!/bin/bash

export PATH=`realpath ../gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/`:$PATH
echo $PATH

CURRENTDIR=`pwd`
echo "CURRENTDIR: ${CURRENTDIR}"
BUILDDIR=${CURRENTDIR}-build-android
echo "BUILDDIR: ${BUILDDIR}"
if [ -d ${BUILDDIR} ]; then
    rm -rf ${BUILDDIR}
fi
mkdir -p ${BUILDDIR}

echo    "******************************"
echo    "*     Clean Kernel Config     *"
echo    "******************************"
make distclean
echo "make distclean done! [$?]"

echo    "******************************"
echo    "*     Make Kernel Config     *"
echo    "******************************"
make O=${BUILDDIR} ARCH=arm64  CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_defconfig
echo "make rk3399_defconfig done! [$?]"

echo    "******************************"
echo    "*     Make AArch64 Kernel    *"
echo    "******************************"
make O=${BUILDDIR} rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc` | tee log.eaidk610android
echo "make rk3399-eaidk-linux.img done! [$?]"

exit 0
