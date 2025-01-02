#!/usr/bin/env bash

ISO="$1"
DISK_NAME="disk-75G.qcow2"

qemu-img create -f qcow2 "$DISK_NAME" 75G
qemu-system-x86_64 -enable-kvm -m 6G -cdrom "$ISO" -hda "$DISK_NAME" -usb -device u2f-passthru -usb -device usb-ccid 
