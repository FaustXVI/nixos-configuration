{ config, pkgs, ... }:

{
  console = {
    font = "Lat2-Terminus16";
  };
  environment = {
    systemPackages = with pkgs; [
      powerline-fonts
    ];
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.noto
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "NotoSans Nerd Font" ];
        serif = [ "NotoSerif Nerd Font" ];
      };
    };
  };
}
