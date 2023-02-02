{ pkgs,mylib, ...}@args:
{
  imports = mylib.importAllWith args ./.;
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
