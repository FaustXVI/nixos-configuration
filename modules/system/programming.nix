{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gitui
      unstable.jetbrains.idea
      unstable.jetbrains.pycharm
      unstable.jetbrains.clion
      unstable.jetbrains.rust-rover
      docker-compose
      meld
    ];
  };
}
