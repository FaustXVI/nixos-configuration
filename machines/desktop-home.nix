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
  xadetComputer = {
    type = "desktop";
    purposes = [ "perso" "gaming" "youtube" "photo" "home-office" ];
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
