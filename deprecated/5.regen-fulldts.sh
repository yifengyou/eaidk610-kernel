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

rm -f arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux-full.dts
mkdir -p arch/arm64/boot/dts/rockchip/ ; ./scripts/gcc-wrapper.py aarch64-none-linux-gnu-gcc -E -Wp,-MD,arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.d.pre.tmp -nostdinc -I./arch/arm64/boot/dts -I./arch/arm64/boot/dts/include -I./drivers/of/testcase-data -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.dts.tmp arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux.dts ; 

./scripts/dtc/dtc -A --symbols -O dts -o arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux-full.dts -b 0 -i arch/arm64/boot/dts/rockchip/ -Wno-unit_address_vs_reg -Wno-simple_bus_reg -Wno-unit_address_format -Wno-pci_bridge -Wno-pci_device_bus_num -Wno-pci_device_reg -d arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.d.dtc.tmp arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.dts.tmp ; cat arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.d.pre.tmp arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.d.dtc.tmp > arch/arm64/boot/dts/rockchip/.rk3399-eaidk-linux.dtb.d

echo ""
echo ""
ls -alh arch/arm64/boot/dts/rockchip/rk3399-eaidk-linux-full.dts
echo ""
echo ""


rm -f arch/arm64/boot/dts/rockchip/rk3399-eaidk-android-full.dts
mkdir -p arch/arm64/boot/dts/rockchip/ ; ./scripts/gcc-wrapper.py aarch64-none-linux-gnu-gcc -E -Wp,-MD,arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.d.pre.tmp -nostdinc -I./arch/arm64/boot/dts -I./arch/arm64/boot/dts/include -I./drivers/of/testcase-data -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.dts.tmp arch/arm64/boot/dts/rockchip/rk3399-eaidk-android.dts ; 

./scripts/dtc/dtc -A --symbols -O dts -o arch/arm64/boot/dts/rockchip/rk3399-eaidk-android-full.dts -b 0 -i arch/arm64/boot/dts/rockchip/ -Wno-unit_address_vs_reg -Wno-simple_bus_reg -Wno-unit_address_format -Wno-pci_bridge -Wno-pci_device_bus_num -Wno-pci_device_reg -d arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.d.dtc.tmp arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.dts.tmp ; cat arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.d.pre.tmp arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.d.dtc.tmp > arch/arm64/boot/dts/rockchip/.rk3399-eaidk-android.dtb.d

echo ""
echo ""
ls -alh arch/arm64/boot/dts/rockchip/rk3399-eaidk-android-full.dts
echo ""
echo ""

echo "All done![$?]"
