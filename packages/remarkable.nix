{ pkgs, ... }:
let
  version = "3.29.0.1804";
  installerUrl = "https://downloads.remarkable.com/desktop/production/win/reMarkable-${version}-win64.exe";
  installer = pkgs.fetchurl {
    url = installerUrl;
    hash = "sha256-jqK17mgATwwC7lLKKtK+0nhombQMUUQloAPH2asDWKo=";
  };
  binaryName = "reMarkable.exe";
  installDirectory = ''''${HOME}/remarkable'';
  targetDirectory = ''''${HOME}/.remarkable'';
  expectedPath = "${targetDirectory}/${binaryName}";
  wine = "${pkgs.wineWow64Packages.stableFull}/bin/wine";
in
pkgs.writeShellScriptBin "remarkable" ''
  export WINEPREFIX="''${HOME}/.wine-remarkable"
  export WINEARCH="win64"
  export WINE="${wine}"
  if [ ! -f ${expectedPath} ]
  then
    mkdir -p "${installDirectory}"
    ${pkgs.winetricks}/bin/winetricks --force --unattended vcrun2022 corefonts wininet dxvk d3dcompiler_47
    echo "Please install the app in ${installDirectory}, it will later be renamed ${targetDirectory}"
    ${wine} "${installer}" >/dev/null 2>&1
    mv "${installDirectory}" "${targetDirectory}"
  fi

  # --no-sandbox is required for Qt WebEngine to render inside Wine
  ${wine} "${expectedPath}" --no-sandbox --disable-gpu
''
