{ config, pkgs, ... }:

{
  config = 
    let
        inherit (config.xadetComputer) orgs;
    in
  {
    nixpkgs.config.allowUnfree = true;
    # TODO move this to ~/.config/nix/nix.conf and remove it from global config
    sops.templates."nix-github-token.conf" = {
      owner = config.users.users.xadet.name;
      content = let
        tokens = pkgs.lib.concatMapStrings (org: ''github.com/${org}=${config.sops.placeholder."github/orgs/${org}"} '') orgs;
      in ''
        access-tokens = ${tokens}
      '';
    };
    sops.templates."nix.env" = {
      content = ''
        GITHUB_TOKEN=${config.sops.placeholder."github/orgs/eove"}
        NIX_NPM_TOKENS={"npm.pkg.github.com":"${config.sops.placeholder."github/auth_and_packages"}"}
      '';
    };
    sops.templates."github-token_git.conf" = {
      owner = config.users.users.xadet.name;
    content = pkgs.lib.concatMapStrings (org: ''
        [url "https://${config.sops.placeholder."github/orgs/${org}"}@github.com/${org}/"]
            insteadOf = git+ssh://github.com/${org}/

    '') orgs;
    };
    environment.etc."gitconfig" = {
      enable = true;
      text = ''
        [include]
          path = ${config.sops.templates."github-token_git.conf".path};
      '';
    };
    systemd.services.nix-daemon.serviceConfig = {
      EnvironmentFile = config.sops.templates."nix.env".path;
    };
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
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
    virtualisation.vmVariant = {
      nix = {
        optimise.automatic = pkgs.lib.mkForce false;
        gc.automatic = pkgs.lib.mkForce false;
        extraOptions = pkgs.lib.mkForce "";
      };
    };
  };
}
