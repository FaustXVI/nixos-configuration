{ pkgs, lib, config, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        output = {
          criteria = "eDP-1";
          status = "enable";
          scale = 1.175;
        };
      }
      {
        profile =
          {
            name = "docked";
            outputs = [
              {
                criteria = "eDP-1";
                status = "disable";
              }
              {
                criteria = "LG Electronics LG ULTRAWIDE 0x01010101";
                scale = 1.0;
              }
              {
                criteria = "Samsung Electric Company SyncMaster 0x4E563233";
                scale = 1.0;
              }
            ];
          };
      }
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        };
      }
    ];
  };
}
