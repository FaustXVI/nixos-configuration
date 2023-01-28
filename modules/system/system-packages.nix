{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = pkgs.lib.mkOverride 0 "vim";
    };
    systemPackages = with pkgs; [
      wget
      git
      vim
      usbutils
      tree
      gnupg
      file
      gnumake
      automake
      gcc
      aspell
      aspellDicts.en
      aspellDicts.fr
      terminator
      zip
      unzip
      udiskie
      apulse
      pavucontrol
      pasystray
      autorandr
      powerline-fonts
      yubico-piv-tool
      yubikey-personalization
      yubikey-personalization-gui
      home-manager
      htop
      arandr
      autorandr
      virt-manager
    ];
  };
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      virt-manager
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        sansSerif = [ "Noto Sans" ];
        serif     = [ "Noto Serif" ];
      };
    };
  };
  programs = {
    bash = {
      enableCompletion = true;
    };
    ssh = {
      startAgent = false;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    dconf = {
      enable = true;
    };
  };
  services = {
    clamav = {
      daemon. enable = true;
      updater.enable = true;
    };
  };
}
