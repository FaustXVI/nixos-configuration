{ config, ... }:
{
  config = {
    sops.secrets.githubToken = {
      format = "binary";
      sopsFile = ./secrets/githubToken;
    };
    sops.secrets.package_reader_pat = {
      format = "binary";
      sopsFile = ./secrets/package_reader_pat;
    };
  };
}
