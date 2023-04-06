#!/bin/bash

set -e

if [ ! -f ../gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc ] ; then
	# md5sum: f66515e2b589b29b4d03cb9b3d048558
	wget -c https://mirrors.aliyun.com/armbian-releases/_toolchain/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
	tar -vf gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu.tar.xz
	mv gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu ../
else
	echo "cross-compiler gcc already ok!"
fi

echo "All done!"
