{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "home-office" {
    services = {
      avahi = {
        enable = true;
        nssmdns = true;
      };
      printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
      };
    };
    hardware = {
      printers = {
        ensureDefaultPrinter = "home-printer";
        ensurePrinters = [{
          name = "home-printer";
          location = "home";
          description = "HP DeskJet 3762";
          deviceUri = "ipp://192.168.1.84";
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
