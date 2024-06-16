{ pkgs, mylib, ... }@args:
{
  imports = mylib.importAllWith args ./.;
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    autojump = {
      enable = true;
    };
    bat = {
      enable = true;
      #extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch prettybat batwatch batpipe ];
    };
    broot = {
      enable = true;
    };
    btop = {
      enable = true;
    };
    eza = {
      enable = true;
    };
    fzf = {
      enable = true;
    };
    navi = {
      enable = true;
    };
    readline = {
      enable = true;
    };
    taskwarrior = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
  };

  home = {
    shellAliases = let exa = "exa --git --header --icons"; in {
      cat = "bat";
      top = "btop";
      diff = "delta";
      ".." = "cd ..";
      "..." = "cd ../..";
      c = "z";
      ls = "${exa}";
      ll = "${exa} -l";
      la = "${exa} -a";
      lla = "${exa} -la";
    };
    packages = with pkgs; [
      thefuck
      peco
      srm
    ];
  };
}
