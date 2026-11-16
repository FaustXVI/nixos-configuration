{ pkgs, ... }:
let
  version = "3.29.0.1804";
  installerUrl = "https://downloads.remarkable.com/desktop/production/win/reMarkable-${version}-win64.exe";
  installer = pkgs.fetchurl {
    url = installerUrl;
    hash = "sha256-jqK17mgATwwC7lLKKtK+0nhombQMUUQloAPH2asDWKo=";
  };
  binaryName = "reMarkable.exe";
  targetDirectory = ''drive_c/Program Files/reMarkable'';
  expectedPath = ''''${WINEPREFIX}/${targetDirectory}/${binaryName}'';

  # Switch to the Wayland-enabled Wine build
  wine = "${pkgs.wineWow64Packages.full}/bin/wine";
in
pkgs.writeShellScriptBin "remarkable" ''
  export WINEPREFIX="''${HOME}/.wine-remarkable"
  export WINEARCH="win64"
  export WINE="${wine}"
  export WINEDEBUG="-all"

  # --- INSTALLATION PHASE ---
  if [ ! -f "${expectedPath}" ]; then
    echo "1. Initializing clean Wine prefix..."
    ${wine} wineboot --init
    ''${WINE%/*}/wineserver -w

    echo "2. Installing standard dependencies..."
    ${pkgs.winetricks}/bin/winetricks --force --unattended vcrun2022 corefonts wininet d3dcompiler_47 >/dev/null 2>&1
    ''${WINE%/*}/wineserver -w
    
    echo "3. Launching installer on safe graphics stack..."
    echo "Please install to ${targetDirectory}"
    ${wine} "${installer}"
    ''${WINE%/*}/wineserver -w
    
    echo "4. Injecting DXVK via Winetricks (forcing 64-bit)..."
    WINE64="${wine}" ${pkgs.winetricks}/bin/winetricks --force --unattended dxvk >/dev/null 2>&1
    ''${WINE%/*}/wineserver -w
    
  fi

  # --- EXECUTION PHASE ---
  echo "Launching reMarkable natively with DXVK..."
  echo "Get a connection code to https://my.remarkable.com/device/browser"
  ${wine} "${expectedPath}"

''
