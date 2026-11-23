{ config, lib, ... }:
{
  options = {
    xadetComputer = {
      orgs = lib.mkOption {
        type = with lib.types; listOf str;
        default =  builtins.attrNames (builtins.fromJSON (builtins.readFile ./secrets/github_tokens.json)).github.orgs;
      };
    };
  };
  config =
    let
        inherit (config.xadetComputer) orgs;
    in
    {
      sops.secrets = ({
        "github/auth_and_packages" = {
          # see https://github.com/Mic92/sops-nix/issues/604 for why we read json as yaml
          format = "yaml";
          sopsFile = ./secrets/github_tokens.json;
        };
      } // (builtins.foldl'
        (acc: org: {
          "github/orgs/${org}" = {
            format = "yaml";
            sopsFile = ./secrets/github_tokens.json;
          };
        } // acc)
        { }
        orgs)
      );
    };
}
