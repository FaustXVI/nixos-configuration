{ pkgs, ... }:
{
  environment = {
    systemPackages = [ pkgs.remarkable ];
  };
}
