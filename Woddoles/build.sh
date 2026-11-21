#!/usr/bin/env bash
# Gera a ISO do WODDOLES OS. Rode em Debian 12/Ubuntu como usuário normal com sudo.
set -euo pipefail
cd "$(dirname "$0")"

sudo apt-get install -y live-build debootstrap squashfs-tools xorriso \
  grub-pc-bin grub-efi-amd64-bin mtools dosfstools

BUILD=build
mkdir -p "$BUILD" && cd "$BUILD"
sudo lb clean --purge 2>/dev/null || true

lb config \
  --distribution bookworm \
  --architectures amd64 \
  --linux-flavours amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --binary-images iso-hybrid \
  --bootloaders "syslinux,grub-efi" \
  --debian-installer none \
  --memtest none \
  --apt-indices false \
  --iso-application "WODDOLES OS" \
  --iso-volume "WODDOLES_OS" \
  --bootappend-live "boot=live components quiet splash locales=pt_BR.UTF-8 keyboard-layouts=br timezone=America/Fortaleza"

cp -r ../config/package-lists/. config/package-lists/
cp -r ../config/hooks/.         config/hooks/
cp -r ../config/includes.chroot/. config/includes.chroot/
cp -r ../config/includes.chroot/. config/includes.chroot/
mkdir -p config/includes.chroot/usr/share/pixmaps
cp ../assets/logo.svg config/includes.chroot/usr/share/pixmaps/woddoles.svg
sudo lb build 2>&1 | tee ../build.log
echo "ISO gerada: $(ls -1 *.iso)"
