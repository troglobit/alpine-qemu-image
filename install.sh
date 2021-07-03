#!/bin/sh

# would be cool to use dhcp
# but it's kind of annoying w/ bridged networking

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
SSHDOPTS="-c openssh"
NTPOPTS="-c openntpd"
DISKOPTS="-v -m sys /dev/vda"
EOF

setup-alpine -f alpine-answers <<EOF
$ROOT_PASSWORD
$ROOT_PASSWORD
y
EOF

# remount the device, change networking, install our ssh key
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
# and disallow password auth for root
sed -i 's/PermitRootLogin yes//g' /mnt/etc/ssh/sshd_config

# and tell it about a real dns server
cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
EOF

umount /dev/vda3
