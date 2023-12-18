{ config, pkgs, lib, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # needed for obsidian
  ];
  environment = {
    variables = {
      EDITOR = lib.mkForce "vim";
    };
    systemPackages = with pkgs; [
      vim
      obsidian
      pandoc
      texlive.combined.scheme-full
    ];
  };
}
