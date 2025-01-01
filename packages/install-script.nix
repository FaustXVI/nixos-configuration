{ pkgs, self, nixos-anywhere, system, ... }:
let
  config-src = ../.;
  nixosa = nixos-anywhere.packages."${system}".default;
  nixos-anywhere-bin = "${nixosa}/bin/nixos-anywhere";
  gpg = "${pkgs.gnupg}/bin/gpg";
  target = "eove";
in
pkgs.writeShellScriptBin "install-xadet-nixos" ''
  SSHPASS="nixos"
  ADDITIONAL_FILE_DIR=$(${pkgs.coreutils}/bin/mktemp -d)
  mkdir -p $ADDITIONAL_FILE_DIR/root
  AGE_KEY="$ADDITIONAL_FILE_DIR/root/ageKey.txt"
  echo "Created temporary folder $ADDITIONAL_FILE_DIR"
  ${gpg} --import ${config-src}/modules/system/home-manager/crypto/xadet-public.key
  ${gpg} --card-status
  ${gpg} --pinentry-mode loopback -d ${config-src}/keys/ageKey.txt.gpg > $AGE_KEY

  ${pkgs.nixos-facter}/bin/nixos-facter -p facter.json

  # TODO run nixos anywhere
  ${nixos-anywhere-bin} --generate-hardware-config nixos-facter ./facter.json  --flake ${config-src}#${target} --target-host root@localhost --extra-files $ADDITIONAL_FILE_DIR



  ${pkgs.coreutils}/bin/shred -u $AGE_KEY
''
