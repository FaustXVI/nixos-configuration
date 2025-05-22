{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gnupg
    ];
  };
  programs = {
    ssh = {
      startAgent = false;
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;
      };
    };
  };
}
