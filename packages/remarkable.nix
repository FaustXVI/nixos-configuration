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

  # Switch to the Wayland-enabled Wine build
  wine = "${pkgs.wineWow64Packages.full}/bin/wine";
in
pkgs.writeShellScriptBin "remarkable" ''
  export WINEPREFIX="''${HOME}/.wine-remarkable"
  export WINEARCH="win64"
  export WINE="${wine}"

expectedPath="''${WINEPREFIX}/drive_c/Program Files/reMarkable/reMarkable.exe"
  if [ ! -f "''${expectedPath}" ]; then
    expectedPath="''${WINEPREFIX}/drive_c/Program Files (x86)/reMarkable/reMarkable.exe"
  fi

  # --- INSTALLATION PHASE ---
  if [ ! -f "''${expectedPath}" ]; then
    echo "1. Initializing clean Wine prefix..."
    ${wine} wineboot --init
    ''${WINE%/*}/wineserver -w

    echo "2. Installing standard dependencies..."
    ${pkgs.winetricks}/bin/winetricks --force --unattended vcrun2022 corefonts wininet d3dcompiler_47
    ''${WINE%/*}/wineserver -w
    
    # Ensure Wine is using X11 so Sway XWayland gets the presentation
    ${wine} reg add "HKCU\Software\Wine\Drivers" /v Graphics /t REG_SZ /d "x11" /f >/dev/null 2>&1
    ''${WINE%/*}/wineserver -w
    
    echo "3. Launching installer on safe graphics stack..."
    ${wine} "${installer}"
    ''${WINE%/*}/wineserver -w
    
    echo "4. Injecting DXVK via Winetricks (forcing 64-bit)..."
    # The WINE64 variable forces winetricks to bypass its broken architecture check
    WINE64="${wine}" WINEARCH=win64 ${pkgs.winetricks}/bin/winetricks --force --unattended dxvk
    ''${WINE%/*}/wineserver -w
    
    expectedPath="''${WINEPREFIX}/drive_c/Program Files/reMarkable/reMarkable.exe"
  fi

  # --- EXECUTION PHASE ---
  # 1. Strictly forbid Wine from falling back to legacy OpenGL
  export WINEDLLOVERRIDES="dxgi,d3d11,d3d10core,d3d9=n"
  
  # 2. Route Qt graphics to DirectX/DXVK
  export QT_OPENGL=angle
  
  # 3. DXVK and Qt presentation unlocks
  export DXVK_PRESENT_INTERVAL=0
  export vblank_mode=0
  export QSG_RENDER_LOOP=basic
  export DXVK_HUD=fps

  echo "5. Launching reMarkable natively with DXVK..."
  ${wine} "''${expectedPath}" --no-sandbox --disable-features=CalculateNativeWinOcclusion --disable-gpu-compositing

''
