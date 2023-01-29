{ config, ... }: {
  xdg.configFile."nixpkgs/config.nix".source = ./nix/config.nix ;
  home.file.".nix-channels".source = ./nix/nix-channels-root ;
  home.stateVersion = config.system.stateVersion;
}
