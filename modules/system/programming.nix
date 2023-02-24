{ config, pkgs, unstable, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      unstable.jetbrains.idea-ultimate
      unstable.jetbrains.pycharm-professional
      unstable.jetbrains.clion
      docker-compose
    ];
  };
}
