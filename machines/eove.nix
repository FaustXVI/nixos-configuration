{ config, pkgs, ... }:

{
  imports =
    [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/12th-gen-intel"
    ../hardware-configuration.nix
    ../modules
  ];


  xadetComputer = {
    type = "laptop";
    purposes = [ "work" ];
#    yubikeyAutolock = false;
  };

  hardware.enableAllFirmware = true;
#  boot = {
#    kernelPackages = pkgs.linuxPackages_latest;
#    kernelParams = [ 
#      "acpi_osi=linux" 
#      "module_blacklist=hid_sensor_hub"
#      "i915.request_timeout_ms=60000"
#      "intel_iommu=off"
#      "i915.reset=0"
#      "i915.enable_psr=0"
#      "i915.enable_fbc=0"
#      "i915.disable_power_well=1"
#      "i915.enable_guc=0"
#    ];
#  };
  services = {
    xserver = {
      dpi = 96;
    };
    fwupd.enable = true;
  };
  system.stateVersion = "21.05";
}
