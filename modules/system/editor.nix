{ config, pkgs, lib, ... }:

{
  environment = {
    variables = {
      EDITOR = lib.mkForce "vim";
    };
    systemPackages = with pkgs; [
      vim
      obsidian
      pandoc
      texlive.combined.scheme-full
      libreoffice
    ];
  };
}
