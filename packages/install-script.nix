{ pkgs, self, disko, system, target, ... }:
let
  config-src = ../.;
  disko-bin = "${disko.packages.${system}.default}/bin/disko";
  gpg = "${pkgs.gnupg}/bin/gpg";
in
pkgs.writeShellScriptBin "install-xadet-${target}-nixos" ''
  set -ex
  if [[ "$#" -ne 1 ]]; then
    echo "Usage $0 /path/to/disk/to/install"
    exit -1
  fi
  DISK="$1"
  LOCAL_SRC="./nixos-configuration"
  cp -r ${config-src} $LOCAL_SRC
  export SSHPASS="nixos"
  ADDITIONAL_FILE_DIR=$(${pkgs.coreutils}/bin/mktemp -d)
  mkdir -p $ADDITIONAL_FILE_DIR/root $ADDITIONAL_FILE_DIR/home/xadet
  AGE_KEY="$ADDITIONAL_FILE_DIR/root/ageKey.txt"
  FACTER_FILE="$LOCAL_SRC/machines/facter-${target}.json"
  echo "Created temporary folder $ADDITIONAL_FILE_DIR"
  ${gpg} --import $LOCAL_SRC/modules/system/home-manager/crypto/xadet-public.key
  ${gpg} --card-status > /dev/null
  echo "decyphering age key"
  ${gpg} --pinentry-mode loopback -d $LOCAL_SRC/keys/ageKey.txt.gpg > $AGE_KEY

  sudo -E ${pkgs.nixos-facter}/bin/nixos-facter -o $FACTER_FILE
  sudo cp -r $LOCAL_SRC $ADDITIONAL_FILE_DIR/home/xadet

  sudo ${disko-bin} --yes-wipe-all-disks --mode destroy,format,mount --argstr device $DISK $LOCAL_SRC/machines/luks-interactive-login.nix

  sudo nixos-install --no-root-passwd --flake $LOCAL_SRC#${target}

  sudo cp -u -r $ADDITIONAL_FILE_DIR/* /mnt
  sudo chown --reference=/mnt/home/xadet -R /mnt/home/xadet
  sudo chmod --reference=/mnt/home/xadet -R /mnt/home/xadet

  ${pkgs.coreutils}/bin/shred -u $AGE_KEY
''
