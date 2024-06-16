{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "home-office" {
    environment = {
      systemPackages = with pkgs; [
        gnome.simple-scan
      ];
    };
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        drivers = with pkgs; [ hplip gutenprint cups-filters ];
        browsing = true;
      };
    };
    hardware = {
      printers = {
        ensureDefaultPrinter = "home-printer";
        ensurePrinters = [{
          name = "home-printer";
          location = "home";
          description = "HP DeskJet 3762";
          deviceUri = "ipp://192.168.1.84/ipp";
          model = "everywhere";
        }];
      };
      sane = {
        enable = true;
        extraBackends = [ pkgs.hplipWithPlugin ];
      };
    };
  };
}

