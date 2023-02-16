{ mylib, config, pkgs, ... }:

let
  videoNumber="9";
  plugScript = pkgs.writeShellScriptBin "plugCamera" ''
    #!/usr/bin/env bash
    gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 8 -f v4l2 /dev/video${videoNumber}
  '';
in {
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
      ];
    };

    boot = 
    {
      kernelModules = [ "v4l2loopback" "snd-aloop"];
      extraModprobeConfig = ''
        options v4l2loopback exclusive_caps=1 card_label="Alpha 77" video_nr=${videoNumber} max_buffers=2
      '';
      extraModulePackages = [
        config.boot.kernelPackages.v4l2loopback.out
      ];

    };
  };

}
