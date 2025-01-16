{ pkgs, config, mylib, ... }@args:

{

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "!"; # Disable login as root cf : https://discourse.nixos.org/t/how-to-disable-root-user-account-in-configuration-nix/13235/5
        hashedPasswordFile = pkgs.lib.mkForce null;
      };
      xadet = {
        shell = pkgs.fish;
        isNormalUser = true;
        uid = 1000;
        createHome = true;
        extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "lp" "scanner" "video" "wireshark" ];
        hashedPasswordFile = config.sops.secrets.password.path;
        openssh = {
          authorizedKeys = {
            keyFiles = mylib.filesInDir ./ssh-keys;
          };
        };
      };
    };
  };
  home-manager = {
    backupFileExtension = "nixBackup";
    useGlobalPkgs = true;
    users = {
      xadet = import ./home-manager/xadet.nix args;
      root = import ./home-manager/root.nix args;
    };
  };
}
