{ config, mylib, ... }@args:
{
  imports = mylib.importsWith args [ ./shells ];
  config = {
    xdg.configFile."nixpkgs/config.nix".source = ./nix/config.nix;
    home.stateVersion = config.system.stateVersion;
  };
}
