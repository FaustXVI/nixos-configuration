{ pkgs, ... }:
let
  version = "3.14.1.889";
  installerUrl = "https://downloads.remarkable.com/desktop/production/win/reMarkable-${version}-win64.exe";
  installer = pkgs.fetchurl {
    url = installerUrl;
    hash = "sha256-uSsLL95YYrLEXBbZMGQX34hz0KX/vil7GWH+cqZn/z0=";
  };
  binaryName = "reMarkable.exe";
  installDirectory = ''''${HOME}/remarkable'';
  targetDirectory = ''''${HOME}/.remarkable'';
  expectedPath = "${targetDirectory}/${binaryName}";
  wine = "${pkgs.wineWowPackages.unstableFull}/bin/wine64";
in
  pkgs.writeShellScriptBin "remarkable" ''
    export WINEPREFIX="''${HOME}/.wine-remarkable"
    export WINEARCH="win64"
    export WINE="${wine}"
    if [ ! -f ${expectedPath} ]
    then
    mkdir -p ${installDirectory}
    ${pkgs.winetricks}/bin/winetricks --force --unattended vcrun2022
    echo "Please install the app in ${installDirectory}, it will later be renamed ${targetDirectory}"
    ${wine} ${installer} 2>/dev/null >/dev/null
    mv ${installDirectory} ${targetDirectory}
    fi
    ${wine} ${expectedPath}  2>/dev/null >/dev/null
  ''
