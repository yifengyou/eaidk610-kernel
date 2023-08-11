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
echo    "*         Clean              *"
echo    "******************************"
make distclean
echo "make distclean done! [$?]"

echo    "******************************"
echo    "*     Make Kernel Config     *"
echo    "******************************"
make Q= ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_linux_defconfig
echo "-> make rk3399_linux_defconfig done!"

# fix yylloc redefine bug
if [ -f scripts/dtc/dtc-lexer.lex.c ]; then
	sed -i 's/^YYLTYPE yylloc;$/extern YYLTYPE yylloc;/g' scripts/dtc/dtc-lexer.lex.c
fi

echo    "******************************"
echo    "*     Make AArch64 Kernel    *"
echo    "******************************"
make Q= rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc`
echo "-> make rk3399-eaidk-linux.img done!"

echo    "******************************"
echo    "*     Make modules           *"
echo    "******************************"
make Q= modules ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j `nproc`
echo "-> make modules done!"

echo "All done! Bye~"
