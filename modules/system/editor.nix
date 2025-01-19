{ config, pkgs, lib, ... }:

{
  environment = {
    variables = {
      EDITOR = lib.mkForce "vim";
    };
    systemPackages = with pkgs; [
      (vim_configurable.customize {
        name = "vim";
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ vim-wayland-clipboard ];
        };
      })
      obsidian
      pandoc
      texlive.combined.scheme-full
      libreoffice
    ];
  };
}
