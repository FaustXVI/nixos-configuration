{ config, pkgs, unstable, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      unstable.jetbrains.idea-ultimate
      docker-compose
    ];
  };
}
