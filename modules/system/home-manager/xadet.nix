{ mylib, config, pkgs, ... }@args:
{
  imports = mylib.importAllFilteredWith (n: n != "root.nix" && n != "xadet.nix") args ./.;
  config = {
    systemd.user.services.noisetorch = {
      Unit = {
        Description = "Noise torch";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = ["/run/current-system/sw/bin/sleep 0.5"  "${pkgs.noisetorch}/bin/noisetorch -i"];
        ExecStop = "${pkgs.noisetorch}/bin/noisetorch -u";
        Type = "oneshot";
        RemainAfterExit = true;
      };

    };
    home = {
      stateVersion = config.system.stateVersion;
      enableNixpkgsReleaseCheck = true;
    };
    programs = {
      home-manager = {
        enable = true;
      };
    };
  };
}
