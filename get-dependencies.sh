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
	sed -i '/^b2sums/,/^)/d' ./PKGBUILD
	echo -e "\nb2sums=(\n  'SKIP'\n'  SKIP\n)" >> ./PKGBUILD
    makepkg -fs --noconfirm
	ls -la .
	pacman --noconfirm -U *.pkg.tar.*
)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano
