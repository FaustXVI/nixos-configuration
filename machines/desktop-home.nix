{ config, pkgs, inputs, ... }:

let
  LG = "HDMI-A-1";
  Samsung = "DP-3";
  device = "/dev/nvme1n1";
in
{
  imports =
    [
      (import ./common/luks-interactive-login.nix { inherit device pkgs; })
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
      })
  ];
  xadetComputer = {
    type = "desktop";
    purposes = [
      "perso"
      "gaming"
      "youtube"
      "photo"
      "home-office"
      "3dPrinting"
      "llm"
    ];
  };
  services.ollama.package = pkgs.ollama-rocm;
  hardware = {
    graphics.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      XDG_SESSION_TYPE = "wayland";
      __GL_GSYNC_ALLOWED = "1";
      LIBSEAT_BACKEND = "logind";
    };
  };
  services.sunshine = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    capSysAdmin = true;
  };

  home-manager.users.xadet.wayland.windowManager.sway.config = {

    output = {
      "HDMI-A-1" = {
        position = "0,0";
        mode = "2560x1080@60Hz";
      };

      "DP-3" = {
        position = "2560,0";
        mode = "1920x1080@60Hz";
      };
    };

    workspaceOutputAssign = [
      { workspace = "1"; output = "HDMI-A-1"; }
      { workspace = "10"; output = "DP-3"; }
    ];
  };

  system.stateVersion = "24.11";
  time.hardwareClockInLocalTime = true;


}
