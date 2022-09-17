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
    yubioath-desktop
    nix-prefetch-git
    nix-prefetch-scripts
    any-nix-shell
    inetutils
  ];
  xdg.configFile."nixpkgs/config.nix".source = ./config.nix ;
  home.file.".nix-channels".source = ./nix-channels;
  programs = {
    fish = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
  };
}
