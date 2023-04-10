{ mylib, config, pkgs, ... }:

let
  videoNumber = "9";
  plugScript = pkgs.writeShellScriptBin "plugCamera" ''
    #!/usr/bin/env bash
    gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 8 -f v4l2 /dev/video${videoNumber}
  '';
in
{
  config = mylib.mkIfComputerHasPurpose "youtube" {
    home-manager.users.xadet = {
      programs = {
        obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            obs-gstreamer
            obs-source-record
          ];
        };
      };
    };
    environment = {
      systemPackages = with pkgs; [
        openshot-qt
        gphoto2
        ffmpeg
        v4l-utils
        simplescreenrecorder
        plugScript
        inkscape
        (kdenlive.overrideAttrs (attrs: { qtWrapperArgs = attrs.qtWrapperArgs or [] ++ [ "--prefix GST_PLUGIN_PATH : ${ lib.makeSearchPath "lib/gstreamer-1.0" (with gst_all_1; [  gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad ]) }" "--set LADSPA_PATH ${ladspaPlugins}/lib/ladspa:${rnnoise-plugin}/lib/ladspa" ]; } ))
      ];
    };

    boot =
      {
        kernelModules = [ "v4l2loopback" "snd-aloop" ];
        extraModprobeConfig = ''
          options v4l2loopback exclusive_caps=1 card_label="Alpha 77" video_nr=${videoNumber} max_buffers=2
        '';
        extraModulePackages = [
          config.boot.kernelPackages.v4l2loopback.out
        ];

      };
  };

}
