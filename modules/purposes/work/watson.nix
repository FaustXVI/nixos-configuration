{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    home-manager.users.xadet = {
      programs = {
        watson = {
          enable = true;
          settings = {
            options = {
              stop_on_start = true;
              stop_on_restart = true;
              log_current = true;
              report_current = true;
            };
          };
        };
        starship = {
          settings = {
            custom = {
              watson = {
                command = "watson status -p";
                format = "[](bg:path fg:watson)[$symbol($output )]($style)[](fg:path bg:watson)";
                style = "bg:watson";
                symbol = "﨟";
                when = "watson status -p | grep -v \"No project\"";
              };
            };
          };
        };
      };
    };
    systemd.services.stop-watson = {
      description = "Stop xadet watson log on poweroff";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = "xadet";
        Before = [ "shutdown.target" "reboot.target" ];
        RemainAfterExit = true;
        ExecStart = ''${pkgs.coreutils}/bin/true'';
        ExecStop = ''${pkgs.watson}/bin/watson stop'';
      };
    };
  };
}
