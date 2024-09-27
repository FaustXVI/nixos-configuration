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
  wine = "${pkgs.wine64Packages.staging}/bin/wine64";
  remarkable = pkgs.writeShellScriptBin "remarkable" ''
    if [ ! -f ${expectedPath} ]
    then
    mkdir -p ${installDirectory}
    echo "Install the app in ${installDirectory}, it will later be renamed ${targetDirectory}"
    ${wine} ${installer} 2>/dev/null >/dev/null
    mv ${installDirectory} ${targetDirectory}
    fi
    ${wine} ${expectedPath}  2>/dev/null >/dev/null
  '';
in
{
  environment = {
    systemPackages = [ remarkable ];
  };
}
