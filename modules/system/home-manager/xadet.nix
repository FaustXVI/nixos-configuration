{mylib,...}@args:
let
  unstable = import <nixos-unstable> {};
in {
  imports = mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") (args // {inherit unstable;}) ./.;
  config = {
    home.stateVersion = "22.05";
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}
