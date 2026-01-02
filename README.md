NINTERNETES OS
==============

NINTERNETES OS es un sistema Linux mínimo para PowerPC construido a mano.
Kernel vanilla, BusyBox, initramfs propio y ejecución directa sobre QEMU
emulando hardware Power Macintosh clásico.

No es una distro.
No es un fork.
No es un experimento académico.

Es un sistema operativo real, pequeño y entendible, pensado para aprender,
tocar y romper sin capas mágicas por encima.

---

Qué es
------

- Linux 6.6.x compilado manualmente para PowerPC
- Initramfs propio con BusyBox
- Arranque directo con QEMU (sin GRUB, sin systemd)
- Red funcional por DHCP
- Dropbear SSH opcional
- Todo controlado desde /init

---

Qué no es
---------

- No usa systemd
- No usa Buildroot
- No usa Yocto
- No usa OpenWRT
- No usa ningún framework de build automático

Aquí se ve todo. Si algo arranca, sabes por qué.

---

Estructura del repositorio
--------------------------

kernel/
  Árbol completo del kernel Linux compilado para PowerPC
  Incluye .config y binarios generados

initramfs/
  Root filesystem en RAM
  Contiene /init, BusyBox y configuración mínima

initramfs.gz
  Initramfs empaquetado listo para QEMU

scripts/
  Scripts auxiliares para build, arranque y utilidades

docs/
  Documentación adicional del proyecto

---

Requisitos
----------

- Host Linux
- qemu-system-ppc
- gcc powerpc-linux-gnu
- make, cpio, gzip

En Debian/Ubuntu:

  apt install qemu-system-ppc gcc-powerpc-linux-gnu cpio gzip make

---

Arranque
--------

Desde la raíz del repo:

  qemu-system-ppc \
    -M g3beige \
    -cpu 750 \
    -m 256 \
    -kernel kernel/vmlinux \
    -initrd initramfs.gz \
    -append "console=ttyS0 rdinit=/init ip=dhcp" \
    -netdev user,id=net0 \
    -device rtl8139,netdev=net0 \
    -nographic

Si todo va bien, aparecerá el banner de NINTERNETES OS y una shell BusyBox.

---

SSH (opcional)
--------------

Dropbear puede lanzarse manualmente dentro del sistema:

  /sbin/dropbear -F -p 22

Desde el host:

  ssh root@IP_DEL_PPC

La clave pública debe estar en:

  /root/.ssh/authorized_keys

---

Identidad del sistema
---------------------

El sistema se identifica como:

  Linux 6.6.x-NINTERNETES_OS_v0.1_PowerPC_Powered_by_Ju4nlux

Nada de genéricos.

---

Motivación
----------

Entender Linux desde abajo.
Ver qué pasa entre el kernel y la shell.
Tener un sistema que puedas leer entero en una tarde.

---

Autor
-----

Ju4nlux  
Proyecto personal  
Madrid  

