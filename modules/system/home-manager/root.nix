{ config, ... }:
let
  channelVersion = "22.11";
in
{
  xdg.configFile."nixpkgs/config.nix".source = ./nix/config.nix;
  home.file.".nix-channels".text = ''
    https://github.com/nix-community/home-manager/archive/release-${channelVersion}.tar.gz home-manager
    https://nixos.org/channels/nixos-${channelVersion} nixos
    https://nixos.org/channels/nixos-unstable nixos-unstable
  '';
  home.stateVersion = config.system.stateVersion;
}
