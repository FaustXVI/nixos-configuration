{ config, ... }:

{
  system = {
    autoUpgrade = {
      enable = true;
      dates = "13:00";
      persistent = true;
      flake = "/home/xadet/nixos-configuration#${config.usedFlake}";
      flags = [ "--refresh" "--recreate-lock-file" ];
    };
  };
}
