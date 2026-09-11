#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm glu libvpx sdl2-compat

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano gtk2-mini libdecor-mini

echo "Building EDuke32..."
echo "---------------------------------------------------------------"
BVER="20260807-10669-ec5824db8"
REPO="http://dukeworld.com/eduke32/synthesis/$BVER/eduke32_src_$BVER.tar.xz"
wget "$REPO"
echo $BVER > ~/version

tar -xvf ./eduke32_src_$BVER.tar.xz
rm -f ./*.xz
mkdir -p ./AppDir/bin
cd ./eduke32_$BVER
make PACKAGE_REPOSITORY=1 VC_REV=10664-ba6b7bb1d -j$(nproc)
mv -v eduke32 mapster32 ../AppDir/bin
