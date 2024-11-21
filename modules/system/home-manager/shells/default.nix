{ pkgs, mylib, ... }@args:
{
  imports = mylib.importAllWith args ./.;
  xdg.configFile."direnv/direnvrc".source = ./direnvrc;
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
    mcfly = {
      enable = true;
      fzf = {
        enable = true;
      };
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
    ripgrep = {
      enable = true;
    };
    fd = {
      enable = true;
    };
    taskwarrior = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
    atuin = {
      enable = true;
      flags = ["--disable-up-arrow"];
      settings = {
        search_mode = "skim";
      };
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
      #cd = "z";
      ls = "${exa}";
      ll = "${exa} -l";
      la = "${exa} -a";
      lla = "${exa} -la";
    };
    packages = with pkgs; [
      viu
      thefuck
      peco
      srm
    ];
  };
}
