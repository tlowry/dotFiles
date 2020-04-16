#!/bin/sh
virt-install \
--name cent8 \
--description "Test VM with CentOS 8" \
--ram=4096 \
--vcpus=2 \
--os-type=Linux \
--os-variant=rhel8.1 \
--disk path=/var/lib/libvirt/images/centos8.qcow2,bus=virtio,size=10 \
--vnc \
--location /run/media/stor/misc/OS/CentOS-8.1.1911-x86_64-dvd1.iso \
--network bridge:br0  \
--extra-args ro
