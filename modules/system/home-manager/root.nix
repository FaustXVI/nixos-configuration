{ config, mylib, pkgs, ... }@args:
{
  imports = [
    pkgs.inputs.catppuccin.homeManagerModules.catppuccin
  ] ++ (mylib.importsWith args [ ./shells ]);
  config = {
    catppuccin = {
      accent = config.catppuccin.accent;
      flavor = config.catppuccin.flavor;
      enable = true;
    };
    xdg.configFile."nixpkgs/config.nix".source = ./nix/config.nix;
    home.stateVersion = config.system.stateVersion;
  };
}
