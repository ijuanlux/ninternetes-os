WELCOME TO NINTERNETES OS v0.1

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

WHAT THIS PROJECT IS

NINTERNETES OS is a learning operating system.

It consists of:

- A manually compiled Linux kernel for PowerPC
- A minimal initramfs built by hand
- BusyBox as the only userspace
- Optional SSH access via Dropbear
- Direct boot into a shell as PID 1
- No background services
- Nothing auto-starts unless you tell it to
- Everything is visible, readable, and hackable

This OS is designed to be understood in an afternoon if you actually look at it.

---

WHAT THIS PROJECT IS NOT

This is not a general-purpose OS.
This is not secure.
This is not optimized.
This is not production-ready.
This is not pretty.

This project exists to learn, not to ship.

---

PROJECT STRUCTURE

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

No magic.
No generators.
No hidden steps.

---

TESTED ENVIRONMENTS

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
VMware does NOT run PowerPC Linux kernels.

If you want a GUI on macOS, use UTM.
If you want raw power, use QEMU directly.

---

REQUIRED TOOLS

macOS:
- Homebrew
- QEMU (qemu-system-ppc)

Linux:
- QEMU with PowerPC support
- Standard build tools (gcc, make, binutils)

Verify PowerPC support with:
qemu-system-ppc --version

---

RUNNING NINTERNETES OS

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

SSH ACCESS (OPTIONAL)

Dropbear is included but NOT auto-started.
This is intentional.

Inside the OS:
- start-ssh   -> starts the SSH server
- stop-ssh    -> stops the SSH server

From the host:

ssh \
  -o StrictHostKeyChecking=no \
  -o UserKnownHostsFile=/dev/null \
  -i ppc_dropbear_key \
  -p 2222 root@127.0.0.1

Nothing listens unless you start it.
You are always in control.

---

NETWORKING

- QEMU user-mode networking
- DHCP inside the guest
- Outbound internet access works
- Host port 2222 forwarded to guest port 22

Simple.
Portable.
Predictable.

---

KERNEL REBUILD (OPTIONAL)

Inside kernel directory:

cp ninternetes.config .config
make olddefconfig
make -j$(nproc) vmlinux

Breaking the kernel is part of the process.

---

REPACKING INITRAMFS

From initramfs directory:

find . | cpio -H newc -o | gzip -9 > ../initramfs.gz

No tooling.
No frameworks.
Just UNIX.

---

THE GAMECUBE INTENT (2001)

This project does not end in QEMU.

QEMU is the dojo.
Real hardware is the destination.

The long-term goal of NINTERNETES OS is to run on a real Nintendo GameCube,
released in 2001.

Why the GameCube?

- Real PowerPC silicon (IBM Gekko, PPC 750-derived)
- No UEFI
- No BIOS comfort
- No safety nets
- No abstraction layers
- No excuses

Just silicon, memory, and code.

The GameCube represents a moment in time where hardware was simple, brutal,
and honest.

Running Linux on it forces real understanding of:

- Boot process
- Memory layout
- Hardware constraints
- Platform-specific drivers
- What Linux actually needs to exist

This repository does NOT claim GameCube support today.

This is an intention.
A direction.
A long road.

The console is not the goal.
Understanding is.

---

PHILOSOPHY

This OS exists to understand:

- How Linux boots
- What PID 1 really is
- How initramfs works
- Where kernel stops and userspace begins

If you break it, good.
If you rebuild it, better.
If you understand it, mission accomplished.

---

CREDITS

Built by Ju4nlux
Powered by Linux, BusyBox, Dropbear and QEMU

Late nights.
Raw terminals.
No safety nets.

---

FINAL WORDS

NINTERNETES OS is not here to impress.

It is here to teach.

If you cloned it and learned something, it worked.

Welcome to the OS.
