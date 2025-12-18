#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q cartridges | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/page.kramo.Cartridges.svg
export DESKTOP=/usr/share/applications/page.kramo.Cartridges.desktop
export DEPLOY_SYS_PYTHON=1
export DEPLOY_OPENGL=1
export DEPLOY_GTK=1
export GTK_DIR=gtk-4.0
export ANYLINUX_LIB=1
export DEPLOY_LOCALE=1
export STARTUPWMCLASS=cartridges
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/cartridges \
             /usr/lib/cartridges-search-provider \
             /usr/lib/libgirepository*

# Patch cartridges python script to use AppImage directories
sed -i 's|"/usr/share/cartridges"|os.getenv("SHARUN_DIR", "/usr") + "/share/cartridges"|' ./AppDir/bin/cartridges
sed -i 's|"/usr/share/locale"|os.getenv("SHARUN_DIR", "/usr") + "/share/locale"|' ./AppDir/bin/cartridges

# Copy needed files for search-integration into gnome-shell
mkdir -p ./AppDir/share/dbus-1/services/ ./AppDir/share/gnome-shell/search-providers/
cp -v /usr/share/dbus-1/services/page.kramo.Cartridges.SearchProvider.service ./AppDir/share/dbus-1/services/page.kramo.Cartridges.SearchProvider.service
cp -v /usr/share/gnome-shell/search-providers/page.kramo.Cartridges.SearchProvider.ini ./AppDir/share/gnome-shell/search-providers/page.kramo.Cartridges.SearchProvider.ini

# Turn AppDir into AppImage
quick-sharun --make-appimage
