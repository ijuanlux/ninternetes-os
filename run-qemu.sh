#!/bin/bash

KERNEL=kernel/vmlinux
INITRD=initramfs.gz

if [ ! -f "$KERNEL" ]; then
  echo "[!] Kernel not found at $KERNEL"
  echo "[!] You must build the kernel first."
  echo
  echo "From kernel/ directory:"
  echo "  cp ninternetes.config .config"
  echo "  make olddefconfig"
  echo "  make -j\$(nproc) vmlinux"
  exit 1
fi

if [ ! -f "$INITRD" ]; then
  echo "[!] initramfs.gz not found"
  echo "[!] You must pack the initramfs first."
  echo
  echo "From initramfs/ directory:"
  echo "  find . | cpio -H newc -o | gzip -9 > ../initramfs.gz"
  exit 1
fi

exec qemu-system-ppc \
  -M g3beige \
  -cpu 750 \
  -m 256 \
  -kernel "$KERNEL" \
  -initrd "$INITRD" \
  -append "console=ttyS0,9600 rdinit=/init ip=dhcp" \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device rtl8139,netdev=net0 \
  -nographic
