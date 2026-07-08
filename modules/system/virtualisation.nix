{ config, ... }:
{
  virtualisation.vmVariant.virtualisation = {
    memorySize = 1024 * 6;
    cores = 4;
    msize = 16384 * 4;
    diskSize = 1024 * 10;
    forwardPorts = builtins.map
      (port:
        { host.port = (10000 + port); guest.port = port; }
      )
      config.networking.firewall.allowedTCPPorts;
  };
}
