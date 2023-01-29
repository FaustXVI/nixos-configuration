{ config, pkgs, ... }:

{
  imports =
    [
    ../hardware-configuration.nix
    ../modules
  ];


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" ];
#    yubikeyAutolock = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ 
      "acpi_osi=linux" 
      "module_blacklist=hid_sensor_hub"
      "i915.request_timeout_ms=60000"
      "intel_iommu=off"
      "i915.reset=0"
      "i915.enable_psr=0"
      "i915.enable_fbc=0"
      "i915.disable_power_well=1"
      "i915.enable_guc=0"
    ];
  };
  services = {
    xserver = {
      dpi = 96;
    };
  };
  system.stateVersion = "21.05";
}
