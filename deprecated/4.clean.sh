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

echo "All done! Bye~"
