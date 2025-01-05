{ pkgs, ... }:
{
  environment = {
    systemPackages = [ pkgs.remarkable pkgs.dedrm ];
  };
}
