{ self, pkgs, ... }:
pkgs.writeShellScriptBin "test-install-xadet" ''
  DISK_NAME="disk-75G.qcow2"

  qemu-img create -f qcow2 "$DISK_NAME" 75G
  qemu-system-x86_64 -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
  -enable-kvm -m 6G -cdrom ${self.installIso}/iso/*.iso -hda "$DISK_NAME" "$@"
''
