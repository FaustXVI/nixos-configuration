# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{ self, pkgs, target,... }:
pkgs.writeShellScriptBin "test-install-${target}" ''
    DISK_NAME="disk-75G.qcow2"

    qemu-img create -f qcow2 "$DISK_NAME" 75G
    qemu-system-x86_64 -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
    -enable-kvm -m 6G -cdrom ${self.installIso.${target}}/iso/*.iso -hda "$DISK_NAME" "$@"
      ''
