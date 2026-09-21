{ config, ... }:
{
  config = {
    sops.secrets.githubToken = {
      format = "binary";
      sopsFile = ./secrets/githubToken;
    };
    sops.secrets.githubToken-readonly = {
      format = "binary";
      sopsFile = ./secrets/githubToken-readonly;
    };
  };
}
