{ ...}:
with import <nixos-unstable> {};
{
  imports = [
    ./git.nix
    ./bash.nix
    ./i3.nix
    ./emacs.nix
    ./vim.nix
    ./fish.nix
    ./gpg.nix
    ./terminator.nix
  ];
  home.packages = [
    firefox
    google-chrome
    thefuck
    peco
    powerline-fonts
    jetbrains.idea-ultimate
    nix-index
    rlwrap
    discord
    spotify
    slack
    vlc
    emacs
    feh
    simplescreenrecorder
    gimp
    rawtherapee
    shotwell
    docker-compose
    blueman
    libreoffice
    patchelf
    autoPatchelfHook
    srm
    dia
    fzf
    gitAndTools.hub
    autojump
    yubioath-flutter
    nix-prefetch-git
    nix-prefetch-scripts
    any-nix-shell
    #inetutils
    usbutils
    oh-my-fish
    bat
    exa
  ];
  xdg.configFile."nixpkgs/config.nix".source = ./config.nix ;
  #home.file.".nix-channels".source = ./nix-channels;
  home.stateVersion = "22.05";
  programs = {
    fish = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    home-manager = {
      enable = true;
    };
  };
}
