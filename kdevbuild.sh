#!/bin/bash

set -xe

# install dependency
apt-get install -y libc6-i386
if [ ! -d gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu ]; then
  cat dependency/* | tar -Jxvf -
fi
export PATH=$(realpath gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/):$PATH

# config kernel
make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" rockchip_linux_defconfig

if [ -f scripts/dtc/dtc-lexer.lex.c ]; then
  sed -i 's/^YYLTYPE yylloc;$/extern YYLTYPE yylloc;/g' scripts/dtc/dtc-lexer.lex.c
fi

# build dtbs
make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" dtbs -j$(nproc)

# build kernel
make ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j$(nproc)

# build kernel module
make modules ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j$(nproc)

make Q= rk3399-eaidk-linux.img ARCH=arm64 CROSS_COMPILE="aarch64-none-linux-gnu-" -j$(nproc)

# install module
make ARCH=arm64 \
  CROSS_COMPILE="aarch64-none-linux-gnu-" \
  INSTALL_MOD_PATH=$(pwd)/kos \
  modules_install

ls -alh ./arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux.dtb

# output sum
ls -alh boot.img
md5sum boot.img
sha256sum boot.img

echo "All done!"
