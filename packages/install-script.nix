{ pkgs, self, nixos-anywhere, system, target, ... }:
let
  config-src = ../.;
  nixosa = nixos-anywhere.packages."${system}".default;
  nixos-anywhere-bin = "${nixosa}/bin/nixos-anywhere";
  gpg = "${pkgs.gnupg}/bin/gpg";
in
pkgs.writeShellScriptBin "install-xadet-${target}-nixos" ''
  set -e
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
  chown nixos $FACTER_FILE
  chmod 777 $FACTER_FILE
  cp -r $LOCAL_SRC $ADDITIONAL_FILE_DIR/home/xadet

  ${nixos-anywhere-bin} --flake $LOCAL_SRC#${target} --target-host root@localhost --extra-files $ADDITIONAL_FILE_DIR --env-password

  ${pkgs.coreutils}/bin/shred -u $AGE_KEY
''
