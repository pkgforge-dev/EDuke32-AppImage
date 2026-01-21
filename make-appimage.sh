#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q eduke32 | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/src/eduke32_20251111-10652-39967d866/duke3d/rsrc/game_icon.ico
export DESKTOP=eduke32.desktop
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /src/eduke32_20251111-10652-39967d866/eduke32

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
