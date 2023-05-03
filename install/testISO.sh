#!/usr/bin/env bash

ISO="$1"
DISK_NAME="disk-50G.qcow2"

qemu-img create -f qcow2 "$DISK_NAME" 50G
qemu-system-x86_64 -enable-kvm -m 6G -cdrom "$ISO" -hda "$DISK_NAME"
