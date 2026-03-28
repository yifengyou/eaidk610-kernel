#!/bin/bash

set -xe

if [ ! -d gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu ]; then
  cat dependency/* | tar -Jxvf -
fi

export PATH=$(realpath gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/):$PATH
echo $PATH

make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_linux_defconfig

if [ -f scripts/dtc/dtc-lexer.lex.c ]; then
  sed -i 's/^YYLTYPE yylloc;$/extern YYLTYPE yylloc;/g' scripts/dtc/dtc-lexer.lex.c
fi

make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" dtbs -j $(nproc)

make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j $(nproc)

make modules ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j $(nproc)

make rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j $(nproc)

echo "All done!"
