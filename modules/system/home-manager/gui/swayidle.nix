{ pkgs, lib, config, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 1 * 60;
        command = "${lib.getExe pkgs.hyprlock} --grace 30";
      }
    ];
  };
}
