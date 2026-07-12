{ pkgs, lib, config, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 5 * 60;
        command = "${lib.getExe pkgs.swaylock}";
      }
    ];
  };
}
