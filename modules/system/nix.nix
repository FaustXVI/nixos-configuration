{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  sops.templates."nix-github-token.conf".content = ''
    access-tokens = github.com=${config.sops.placeholder.githubToken}
  '';
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [
        "root"
        config.users.users.xadet.name
      ];
    };
    extraOptions = ''
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
      !include ${config.sops.templates."nix-github-token.conf".path}
    '';
    gc = {
      dates = "13:10";
      automatic = true;
      options = "--delete-older-than 90d";
    };
    optimise = {
      dates = [ "13:20" ];
      automatic = true;
    };
  };
}
