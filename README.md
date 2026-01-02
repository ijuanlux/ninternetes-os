# NINTERNETES OS

PowerPC Linux playground — kernel + initramfs, no distro, no bullshit

NINTERNETES OS is a personal operating system project built from scratch.  
This is not a Linux distribution. This is not a VM image. This is not “Linux from scratch”.

This is a raw Linux kernel + a handcrafted initramfs, booting directly into a BusyBox shell on PowerPC, with optional SSH access via Dropbear.

No systemd  
No package manager  
No installer  
No GUI  

Just kernel, userspace, and you.

---

## What this project is

Custom Linux kernel (PowerPC) compiled manually  
Minimal initramfs built by hand  
BusyBox as the only userspace  
Optional Dropbear SSH server  
Boots directly to shell  
Designed to be readable and hackable in an afternoon

---

## What this project is NOT

Not a general-purpose OS  
Not secure  
Not optimized  
Not production-ready  
Not pretty  

This is a learning OS.

---

## Project structure

ninternetes-os  
├── kernel  
│   ├── ninternetes.config  
│   ├── vmlinux  
│   └── Linux kernel source tree  
├── initramfs  
│   ├── init  
│   ├── bin  
│   ├── sbin  
│   ├── etc  
│   ├── root  
│   │   └── .ssh  
│   │       └── authorized_keys  
│   └── minimal root filesystem  
├── initramfs.gz  
├── scripts  
├── docs  
└── README.md

---

## Requirements

### macOS
Homebrew  
QEMU

### Linux PC
QEMU  
Standard build tools

---

## Installing QEMU

### macOS
brew install qemu

Verify PowerPC support:
qemu-system-ppc --version

### Linux
sudo apt install qemu-system-ppc

---

## Running NINTERNETES OS

Recommended way is QEMU PowerPC emulation.

### Boot command

qemu-system-ppc \
  -M g3beige \
  -cpu 750 \
  -m 256 \
  -kernel kernel/vmlinux \
  -initrd initramfs.gz \
  -append "console=ttyS0,9600 rdinit=/init ip=dhcp" \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device rtl8139,netdev=net0 \
  -nographic

---

## First boot

You should see a NINTERNETES OS banner and land directly in a BusyBox shell.

This is your OS running. No layers. No safety net.

---

## SSH access (optional)

Dropbear is included but not auto-started.

### Start SSH server inside the OS

start-ssh

### Stop SSH server

stop-ssh

### Connect from host

ssh \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/dev/null \
  -i ppc_dropbear_key \
  -p 2222 \
  root@127.0.0.1

---

## Networking

Uses QEMU user-mode networking  
Guest gets IP via DHCP  
Host port 2222 is forwarded to guest port 22  
Guest has outbound internet access

---

## Kernel rebuild (optional)

cd kernel  
cp ninternetes.config .config  
make olddefconfig  
make -j$(nproc) vmlinux

---

## Repacking initramfs

cd initramfs  
find . | cpio -H newc -o | gzip -9 > ../initramfs.gz

---

## VMware note

VMware does NOT support PowerPC Linux kernels.

This project will not run on VMware directly.

Use QEMU or UTM (which wraps QEMU).

---

## Why PowerPC

No shortcuts  
No distro magic  
Forces real understanding  
You actually learn something

---

## Philosophy

This OS exists to understand how Linux really boots.

PID 1  
initramfs  
kernel/userspace boundary  
minimal userspace  

If you break it, good.  
If you rebuild it, better.  
If you understand it, mission accomplished.

---

## Credits

Built by Ju4nlux  
Powered by Linux, BusyBox, Dropbear and QEMU

---

## Final words

This OS is not here to impress.  
It is here to teach.
