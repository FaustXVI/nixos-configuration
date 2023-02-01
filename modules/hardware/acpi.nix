{ pkgs, mylib, ... }:

{
  config = mylib.mkIfComputerIs "laptop" {
    environment.systemPackages = with pkgs; [
      acpi
    ];

    services = {
      acpid = {
        enable = true;
      };
    };
  };

}
