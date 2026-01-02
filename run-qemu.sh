#!/bin/bash

set -e

KERNEL="./kernel/vmlinux"
INITRD="./initramfs.gz"

if [[ ! -f "$KERNEL" ]]; then
  echo "[!] Kernel not found at $KERNEL"
  exit 1
fi

if [[ ! -f "$INITRD" ]]; then
  echo "[!] initramfs.gz not found"
  exit 1
fi

echo "[+] Booting NINTERNETES OS (PowerPC)"

qemu-system-ppc \
  -M g3beige \
  -cpu 750 \
  -m 256 \
  -kernel "$KERNEL" \
  -initrd "$INITRD" \
  -append "console=ttyS0,9600 rdinit=/init ip=dhcp" \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device rtl8139,netdev=net0 \
  -nographic
