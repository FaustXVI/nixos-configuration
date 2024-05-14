{ config, pkgs, lib, ... }:

{
  environment = {
    variables = {
      EDITOR = lib.mkForce "vim";
    };
    systemPackages = with pkgs; [
      vim
#      obsidian
    ];
  };
}
