{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # TODO move this to ~/.config/nix/nix.conf and remove it from global config
  sops.templates."nix-github-token.conf" = {
    owner = config.users.users.xadet.name;
    content = ''
      access-tokens = github.com=${config.sops.placeholder.githubToken}
      impure-env = GITHUB_TOKEN=${config.sops.placeholder.githubToken}
      extra-impure-env = NIX_NPM_TOKENS={"npm.pkg.github.com":"${config.sops.placeholder.githubToken}"}
    '';
  };
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "configurable-impure-env" ];
      trusted-users = [
        "@wheel"
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
