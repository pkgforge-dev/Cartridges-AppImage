#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Building package and its dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm cartridges

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano
