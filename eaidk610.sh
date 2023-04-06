#!/bin/sh

export PATH=/data/armbian/kernel_and_uboot/gcc-arm-11.2-2022.02-x86_64-aarch64-none-none-linux-gnu/bin:$PATH

make distclean

echo    "******************************"
echo    "*     Make Kernel Config     *"
echo    "******************************"
make ARCH=arm64  CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_linux_defconfig
echo "make rk3399_linux_defconfig done! [$?]"

echo    "******************************"
echo    "*     Make AArch64 Kernel    *"
echo    "******************************"
make rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc` | tee log.rk3399eaidklinux
echo "make rk3399-eaidk-linux.img done! [$?]"

exit 0
