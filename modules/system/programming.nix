{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gitui
      unstable.jetbrains.idea-ultimate
      unstable.jetbrains.pycharm-professional
      unstable.jetbrains.clion
      unstable.jetbrains.rust-rover
      docker-compose
      meld
    ];
  };
}
