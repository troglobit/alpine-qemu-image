Alpine Qemu Image
=================

This project can be used to create bootable x86_64 Qemu images based on
Alpine Linux.  To achive this https://www.packer.io and some shell
scripts are used.  On Debian/Ubuntu or Linu Mint systems, run:

```bash
~$ sudo apt install packer qemu-system-x86
```

To create `images/alpine-313.qcow` with a scrambled root password and an
SSH key based on your `~/.ssh/id_rsa.pub`, run:

```bash
~$ git clone https://github.com/troglobit/alpine-qemu-image.git
~$ cd alpine-qemu-image/
~/alpine-qemu-image$ ./build
```

To create the same image with the root password `secret`, run:

```bash
~/alpine-qemu-image$ packer build -force packer.json
```

On Linux systems you can give the resulting image a test drive, run:

```bash
~/alpine-qemu-image$ ./run
```


Origin & References
-------------------

This project is based on [startling/alpine-kernel-dev][2], changes to
the original include updating to Alpine Linux 3.13.1 and build fixes
for Linux host systems.

The sole purpose is to provide ready-made Qemu images for projects like
the awesome [wkz/qeneth][3] :-)

[1]: https://www.packer.io
[2]: https://github.com/startling/alpine-kernel-dev
[3]: https://github.com/wkz/qeneth/
