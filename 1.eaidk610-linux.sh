#!/bin/sh

set -e

export PATH=`realpath ../gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/`:$PATH
echo $PATH

echo    "******************************"
echo    "*     Clean Kernel Config     *"
echo    "******************************"
make distclean
echo "make distclean done! [$?]"


echo    "******************************"
echo    "*     Make Kernel Config     *"
echo    "******************************"
make ARCH=arm64  CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_linux_defconfig
echo "make rk3399_linux_defconfig done! [$?]"

# fix yylloc redefine bug
sed -i 's/^YYLTYPE yylloc;$/extern YYLTYPE yylloc;/g' scripts/dtc/dtc-lexer.lex.c

echo    "******************************"
echo    "*     Make AArch64 Kernel    *"
echo    "******************************"
make rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc` | tee log.eaidk610linux
echo "make rk3399-eaidk-linux.img done! [$?]"

make modules ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc` | tee log.eaidk610linux

echo "All done!"
exit 0
