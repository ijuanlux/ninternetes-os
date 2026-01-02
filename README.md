# WELCOME TO NINTERNETES OS v0.1

PowerPC Linux playground.  
Kernel + initramfs.  
No distro. No installers. No bullshit.

NINTERNETES OS is a personal operating system project built from scratch to understand how Linux actually boots, runs, and exposes itself.

This is NOT a Linux distribution.  
This is NOT a VM image.  
This is NOT Linux From Scratch.

This is a raw Linux kernel paired with a handcrafted initramfs, booting straight into a BusyBox shell on PowerPC hardware emulation.

No systemd.  
No package manager.  
No GUI.  
No abstractions.

Just kernel, userspace, and you.

---

## What this project is

NINTERNETES OS is a learning operating system.

It consists of:
- A manually compiled Linux kernel for PowerPC
- A minimal initramfs built by hand
- BusyBox as the only userspace
- Optional SSH access via Dropbear
- Direct boot into a shell as PID 1

No background services.  
Nothing auto-starts unless you tell it to.  
Everything is visible, readable, and hackable.

This OS is designed to be understood in an afternoon if you actually look at it.

---

## What this project is NOT

This is not a general-purpose OS.  
This is not secure.  
This is not optimized.  
This is not production-ready.  
This is not pretty.

This project exists to learn, not to ship.

---

## Project structure

ninternetes-os  
├── kernel  
│   ├── Linux kernel source tree  
│   ├── ninternetes.config  
│   └── vmlinux  
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

No magic. No generators. No hidden steps.

---

## Tested environments

This project has been tested on:

macOS  
- Apple Silicon (ARM64)  
- QEMU installed via Homebrew  
- UTM (QEMU wrapper)

Linux  
- x86_64 host  
- QEMU system emulation  
- Standard GNU toolchain

VMware is NOT supported.  
VMware does not run PowerPC Linux kernels.

If you want a GUI on macOS, use UTM.  
If you want raw power, use QEMU directly.

---

## Required tools

macOS:
- Homebrew
- QEMU (qemu-system-ppc)

Linux:
- QEMU with PowerPC support
- Standard build tools (gcc, make, binutils)

Verify PowerPC support with:
qemu-system-ppc --version

---

## Running NINTERNETES OS

Recommended method is QEMU PowerPC emulation.

Boot command:

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

If everything is working, you will see the NINTERNETES OS banner and land directly in a BusyBox shell.

That shell is PID 1.  
That is the OS.

---

## SSH access (optional)

Dropbear is included but NOT auto-started.

This is intentional.

Inside the OS:

start-ssh   -> starts the SSH server  
stop-ssh    -> stops the SSH server  

From the host:

ssh \
-o StrictHostKeyChecking=no \
-o UserKnownHostsFile=/dev/null \
-i ppc_dropbear_key \
-p 2222 root@127.0.0.1

Nothing listens unless you start it.  
You are always in control.

---

## Networking

- QEMU user-mode networking
- DHCP inside the guest
- Outbound internet access works
- Host port 2222 forwarded to guest port 22

Simple, portable, predictable.

---

## Kernel rebuild (optional)

Inside kernel directory:

cp ninternetes.config .config  
make olddefconfig  
make -j$(nproc) vmlinux  

Rebuilding the kernel is encouraged.  
Breaking it is part of the process.

---

## Repacking initramfs

From initramfs directory:

find . | cpio -H newc -o | gzip -9 > ../initramfs.gz

No tooling.  
No frameworks.  
Just UNIX.

---

## Why PowerPC

PowerPC removes shortcuts.

No distro assumptions.  
No copy-paste kernel configs.  
No accidental success.

If it boots, you earned it.

---

## Philosophy

This OS exists to understand:
- How Linux boots
- What PID 1 really is
- How initramfs works
- Where kernel stops and userspace begins

If you break it, good.  
If you rebuild it, better.  
If you understand it, mission accomplished.

---

## Credits

Built by Ju4nlux  
Powered by Linux, BusyBox, Dropbear and QEMU  

Late nights. Raw terminals. No safety nets.

---

## Final words

NINTERNETES OS is not here to impress.

It is here to teach.

If you cloned it and learned something, it worked.

Welcome to the OS.
