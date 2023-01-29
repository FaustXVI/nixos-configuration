{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      aspell
      aspellDicts.en
      aspellDicts.fr
    ];
  };
}
