{ config, ... }:
{
  config = {
    sops.secrets.githubToken = {
      format = "binary";
      sopsFile = ./secrets/githubToken;
    };
  };
}
