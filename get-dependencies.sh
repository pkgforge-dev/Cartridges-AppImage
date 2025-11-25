#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Building package and its dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm meson jq
wget https://codeberg.org/kramo/cartridges/raw/branch/main/meson.build -O /tmp/meson.build
VER="$(meson introspect /tmp/meson.build --projectinfo | jq -r '.version')"
sed -i 's|EUID == 0|EUID == 69|g' /usr/bin/makepkg
git clone https://gitlab.archlinux.org/archlinux/packaging/packages/cartridges.git ./cartridges && (
	cd ./cartridges
	sed -i -e "s|pkgver=*|pkgver=$VER|" ./PKGBUILD
    sed -i -e "s|pkgrel=*|pkgrel=1|" ./PKGBUILD
    sed -i -e "s|e15ee8046903a4b0307af88ab79c5dc951bfc69ea8a76109fec4690f95ddf6eec8cef2c2d083444e00520493d7e6d2f4c165e2dafcdaa026b4784cfd7bd1fc90|'SKIP'|" ./PKGBUILD
    sed -i -e "s|d0f7ec28c561cc3d6b92943884bc6c467fac642d0f4950e0954061f027d4ecac691436dc8e4d9f863fa7318a9007eafda94cde30b72cf8e8871dfa154b97e299|'SKIP'|" ./PKGBUILD
    makepkg -fs --noconfirm
	ls -la .
	pacman --noconfirm -U *.pkg.tar.*
)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano
