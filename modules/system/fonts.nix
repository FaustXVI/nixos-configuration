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
      nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      virt-manager
      powerline-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };
}
