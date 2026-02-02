#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/pixmaps/eduke32.ico
#export DESKTOP=eduke32.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/eduke32

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
