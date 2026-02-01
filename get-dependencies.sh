#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    alsa-lib  \
    flac      \
    glu       \
    libvorbis \
    libvpx

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package gtk2 sdl2

# If the application needs to be manually built that has to be done down here

echo "Building EDuke32..."
echo "---------------------------------------------------------------"
REPO="http://dukeworld.com/eduke32/synthesis/20251111-10652-39967d866/eduke32_src_20251111-10652-39967d866.tar.xz"
wget "$REPO"

tar -xvf ./eduke32_src_20251111-10652-39967d866.tar.xz
ls
cd eduke32_20251111-10652-39967d866
make PACKAGE_REPOSITORY=1 VC_REV=10652-39967d866 -j $(nproc)

# install binaries, buildlicense, icon and desktop files
install -d /usr/bin
install -m755 eduke32 mapster32 /usr/bin
install -Dm644 package/common/buildlic.txt /usr/share/licenses/eduke32/buildlic.txt
install -Dm644 source/duke3d/rsrc/game_icon.ico /usr/share/pixmaps/eduke32.ico
install -Dm644 ../eduke32.desktop /usr/share/applications/eduke32.desktop
