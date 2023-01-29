{ pkgs, ...}:
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./terminator.nix
  ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
  home.packages = with pkgs; [
    rlwrap
    thefuck
    peco
    fzf
    srm
    autojump
    bat
    exa
  ];
}
