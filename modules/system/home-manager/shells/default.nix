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
    exa = {
      enable = true;
      enableAliases = true;
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
    watson = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
  };

  home = { 
    shellAliases = {
      cat = "bat";
      top = "btop";
      diff = "delta";
      ".." = "z ..";
      "..." = "z ../..";
      cd = "z";
    };
    packages = with pkgs; [
      thefuck
      peco
      srm
    ];
  };
}
