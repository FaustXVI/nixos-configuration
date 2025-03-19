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
    (final: prev: {
      bambu-studio = prev.bambu-studio.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
        postInstall = oldAttrs.postInstall or "" + ''
          wrapProgram $out/bin/bambu-studio --set __EGL_VENDOR_LIBRARY_FILENAMES "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
        '';
      });
    })
  ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "perso" "gaming" "youtube" "photo" "home-office" "3dPrinting" ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
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
