{ config, pkgs, inputs, ... }:

let
  LG = "HDMI-1";
  Samsung = "DP-2";
  device = "/dev/nvme1n1";
in
{
  imports =
    [
      (import ./common/luks-interactive-login.nix { inherit device; })
    ];
  nixpkgs.overlays = [
    (final: prev:
      let
        exports = ''
          export __GLX_VENDOR_LIBRARY_NAME="mesa"
          export __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
          export MESA_LOADER_DRIVER_OVERRIDE="zink"
          export GALLIUM_DRIVER="zink"
          export WEBKIT_DISABLE_DMABUF_RENDERER=1
        '';
      in
      {
        freecad-wayland = final.writeScriptBin "FreeCAD" ''
          ${exports}
          ${prev.freecad-wayland}/bin/FreeCAD "$@"'';
        bambu-studio = final.writeScriptBin "bambu-studio" ''
                      ${exports}
                      ${prev.lib.getExe (prev.bambu-studio.overrideAttrs (oldAttrs: {
          	version = "01.10.01.50";
          	src = prev.fetchFromGitHub {
          		owner = "bambulab";
          		repo = "BambuStudio";
          		rev = "v01.10.01.50";
          		hash = "sha256-7mkrPl2CQSfc1lRjl1ilwxdYcK5iRU//QGKmdCicK30=";
          	};
          }))} "$@"'';
      })
  ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "perso" "gaming" "youtube" "photo" "home-office" "3dPrinting" "llm" ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  services.ollama.package = pkgs.ollama-cuda;
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      powerManagement.enable = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };
  };

  environment = {
    sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      QT_QPA_PLATFORM = "wayland";
      XDG_SESSION_TYPE = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      LIBSEAT_BACKEND = "logind";
      NVD_BACKEND = "direct";
    };
  };

  system.stateVersion = "24.11";
  time.hardwareClockInLocalTime = true;


}
