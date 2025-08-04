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
        version = "2.1.1";
  appimageName = "Bambu_Studio_ubuntu-24.04_PR-7292.AppImage";
  zipUrl = "https://github.com/bambulab/BambuStudio/releases/download/v02.01.01.52/BambuStudio_ubuntu-24.04_PR-7292.zip";
  zipSha256 = "sha256-0xQqDlW0yHnshy6O7nsmOGT49XsLjf6Y8TPnyohp7Sc=";
  srcZipped = pkgs.fetchzip {
    url = zipUrl;
    sha256 = zipSha256;
  };
  appimagePath = "${srcZipped}/${appimageName}";
      in
      {
        freecad-wayland = final.writeScriptBin "FreeCAD" ''
          ${exports}
          ${prev.freecad-wayland}/bin/FreeCAD "$@"'';
        bambu-studio = final.writeScriptBin "bambu-studio" ''
                      ${exports}
                      ${prev.lib.getExe (pkgs.appimageTools.wrapType2 {
    name = "BambuStudio";
    pname = "bambustudio";
    inherit version;
    appimageContents = pkgs.appimageTools.extract {
      src = appimagePath;
    };
    src = appimagePath;
    profile = ''
      export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
    '';
    extraPkgs = pkgs: with pkgs; [
      cacert
      curl
      glib
      glib-networking
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      webkitgtk_4_1
      pkgs.linuxPackages.nvidia_x11
      libglvnd
      fontconfig
      dejavu_fonts
      liberation_ttf
      libxkbcommon
      hack-font
    ];
  })} "$@"'';
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
  services.sunshine = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    capSysAdmin = true;
  };

  system.stateVersion = "24.11";
  time.hardwareClockInLocalTime = true;


}
