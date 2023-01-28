{ config, pkgs, ... }:

{
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernel.sysctl = {
      "kernel.sysrq" = 0;
    };
  };
}
