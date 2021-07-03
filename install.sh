#!/bin/sh

cat > alpine-answers <<EOF
KEYMAPOPTS="us us"
HOSTNAMEOPTS="-n alpine"
# todo: make this configurable
INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
      hostname alpine
"

DNSOPTS="-d example.com 8.8.8.8"
TIMEZONEOPTS="-z UTC"
PROXYOPTS="none"
APKREPOSOPTS="-f"
SSHDOPTS="-c dropbear"
NTPOPTS="-c busybox"
DISKOPTS="-v -m sys /dev/vda"
EOF

setup-alpine -f alpine-answers <<EOF
$ROOT_PASSWORD
$ROOT_PASSWORD
y
EOF

mount /dev/vda3 /mnt
cat > /mnt/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF
mkdir -p /mnt/root/.ssh/
cat >> /mnt/root/.ssh/authorized_keys <<EOF
$SSH_PUBKEY
EOF

cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
EOF

umount /dev/vda3
