{ config, pkgs, inputs, ... }:

let
  laptop = "eDP-1";
  LG = "DP-1";
  Samsung = "DP-2";
  suitable_disk = builtins.head (builtins.filter (d: d ? "bus_type" && ! builtins.any (s: s == "usb") d.class_list) config.facter.report.hardware.disk);
  device = suitable_disk.unix_device_name;
in
{
  imports =
    [
      (import ./common/luks-interactive-login.nix { inherit device; })
    ];
  facter.reportPath = ./facter-eove.json;


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" "home-office" "gaming" "3dPrinting" ];
  };

  system.stateVersion = "24.11";

  nixpkgs.overlays = [(final: prev: {
        bambu-studio = prev.appimageTools.wrapType2 rec {
          name = "BambuStudio";
          pname = "bambu-studio";
          version = "02.04.00.70";
          ubuntu_version = "24.04_PR-8834";

          src = prev.fetchurl {
            url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_ubuntu-${ubuntu_version}.AppImage";
            sha256 = "sha256:26bc07dccb04df2e462b1e03a3766509201c46e27312a15844f6f5d7fdf1debd";
          };

          profile = ''
            export SSL_CERT_FILE="${prev.cacert}/etc/ssl/certs/ca-bundle.crt"
            export GIO_MODULE_DIR="${prev.glib-networking}/lib/gio/modules/"
          '';

          extraPkgs =
            pkgs: with pkgs; [
              cacert
              glib
              glib-networking
              gst_all_1.gst-plugins-bad
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
              webkitgtk_4_1
            ];
        };
  })];
}
