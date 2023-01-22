{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      obs-studio
      obs-studio-plugins.obs-gstreamer
      gphoto2
      ffmpeg
      v4l-utils
    ];
  };

  boot = 
  {
    kernelModules = [ "v4l2loopback" "snd-aloop"];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Alpha 77" video_nr=9 max_buffers=2
    '';
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback.out
    ];

  };

}
