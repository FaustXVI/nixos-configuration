{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "work" {
    systemd.services.stop-watson = {
      description = "Stop xadet watson log on poweroff";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = "xadet";
        Before = [ "shutdown.target" "reboot.target" ];
        RemainAfterExit=true;
        ExecStart = ''${pkgs.coreutils}/bin/true'';
        ExecStop = ''${pkgs.watson}/bin/watson stop'';
      };
    };
  };
}
