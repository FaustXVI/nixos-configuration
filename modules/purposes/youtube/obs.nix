{ mylib, config, pkgs, ... }:

let
  videoNumber = "9";
  plugScript = pkgs.writeShellScriptBin "plugCamera" ''
    ${pkgs.gphoto2}/bin/gphoto2 --stdout --capture-movie | ${pkgs.ffmpeg_6-full}/bin/ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 8 -f v4l2 /dev/video${videoNumber}
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
      variables = {
        VST_PATH = "/nix/var/nix/profiles/default/lib/vst:/var/run/current-system/sw/lib/vst";
        LXVST_PATH = "/nix/var/nix/profiles/default/lib/lxvst:/var/run/current-system/sw/lib/lxvst";
        LADSPA_PATH = "/nix/var/nix/profiles/default/lib/ladspa:/var/run/current-system/sw/lib/ladspa";
        LV2_PATH = "/nix/var/nix/profiles/default/lib/lv2:/var/run/current-system/sw/lib/lv2";
        DSSI_PATH = "/nix/var/nix/profiles/default/lib/dssi:/var/run/current-system/sw/lib/dssi";
      };
      systemPackages = with pkgs; [
        openshot-qt
        gphoto2
        ffmpeg_6-full
        v4l-utils
        simplescreenrecorder
        plugScript
        inkscape
        kdePackages.kdenlive
        ladspaPlugins
        rnnoise-plugin
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
