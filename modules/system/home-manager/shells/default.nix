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
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep ];
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
      settings = {
        cheats = {
          paths = with pkgs.lib;
          map (n: "${pkgs.inputs.${n}}") (
          filter (strings.hasPrefix "navi-") (attrNames pkgs.inputs));
        };
      };
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
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
    yazi = {
      enable = true;
    };
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
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
      ls = "${exa}";
      ll = "${exa} -l";
      la = "${exa} -a";
      lla = "${exa} -la";
      man = "batman";
      grep = "batgrep";
    };
    packages = with pkgs; [
      entr
    ];
  };
}
