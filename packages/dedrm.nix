{ pkgs, ... }:
let
  login = "${pkgs.libgourou}/bin/adept_activate";
  dl = "${pkgs.libgourou}/bin/acsmdownloader";
  deleteDRM = "${pkgs.libgourou}/bin/adept_remove";
in
pkgs.writeShellScriptBin "dedrm" ''
  if [[ "$#" -ne 1 ]]; then
    echo "Usage $0 /path/to/file.acsm"
    exit -1
  fi
  if [[ ! -d "$HOME/.config/adept" ]]
  then
    echo "Please enter adobe login :"
    read $LOG
    ${login} -u $LOG
  fi
  DL_DIR=$(${pkgs.coreutils}/bin/mktemp -d)
  echo "working in temporary folder $DL_DIR"
  ${dl} -O $DL_DIR $1
  ${deleteDRM} $DL_DIR/*.epub
  mv $DL_DIR/*.epub .
''
