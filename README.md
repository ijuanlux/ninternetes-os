# NINTERNETES OS
v0.1 – PowerPC  
Bare metal mindset. No distro. No bullshit.

## What this is

NINTERNETES OS is a minimal Linux operating system built from scratch
for PowerPC architecture.

This is not Debian.
This is not Ubuntu.
This is not Buildroot.
This is not Yocto.

This is straight-up kernel + initramfs + BusyBox + SSH.
Nothing hidden. Nothing pre-cooked.

## Why this exists

Because abstractions make you soft.

This project exists to understand:
- How Linux actually boots
- What the kernel does before userspace shows up
- What PID 1 really is
- How to build a system you can read end-to-end in one afternoon

If something runs here, it's because you put it there.

## Core components

Kernel:
- Linux 6.6.70
- PowerPC 32-bit
- Custom config, hand-tuned

Initramfs:
- Static BusyBox
- Dropbear SSH
- Handwritten /init
- No systemd
- No magic daemons

Userland:
- BusyBox shell
- Minimal tooling
- No persistence by default

## Boot flow

1. Kernel boots
2. initramfs is unpacked
3. /init runs as PID 1
4. /proc, /sys and /dev get mounted
5. Network comes up via DHCP
6. Shell drops in

SSH does NOT auto-start.
You own that decision.

## SSH control

Start SSH:
start-ssh

Stop SSH:
stop-ssh

That’s it.
No service managers. No ghosts.

## System identity

uname -a looks like this:

Linux 10.0.2.15 6.6.70-NINTERNETES_OS_v0.1_PowerPC_Powered_by_Ju4nlux

Yeah, the kernel name is custom.
Yeah, that’s intentional.

## Who this is for

- Linux engineers
- Kernel nerds
- Infra people who want the real deal
- Anyone tired of bloated stacks and fake complexity

If you want comfort, look elsewhere.
If you want control, welcome home.

Powered by Ju4nlux.
Built by hand. Old school. No mercy.
