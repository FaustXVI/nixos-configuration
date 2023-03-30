{ pkgs, ... }@args:

{

  imports =
    [
      <home-manager/nixos>
    ];

  environment = {
    systemPackages = with pkgs; [
      home-manager
    ];
  };
  users = {
    mutableUsers = true;
    extraUsers = {
      xadet = {
        shell = pkgs.fish;
        isNormalUser = true;
        uid = 1000;
        createHome = true;
        extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "lp" "scanner" "video" ];
        initialPassword = "changeMe";
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5pquvfcFOWb81kW5GQCpn9jTvxaAztCPCcvhARyxCSK6ovPjuTNPwH2VDN4huBaSdITguyzKuurZkDGFOEO9XIv7isDQ0GIMwQbyuXUKIaQFRpAQQiq916ysz8kGbAOZenvR5TFkJd1cPIR9o4R+QFltOz/SJLFxDodtj5tm3HXzFNmjdKz/BCTy8ZPmq7KHohCFRygR+rpiORArsAQMPQX3bOZW5SgvBNPVIu2Nhpcgdo6aUKHJnLmQLW4LEujpt+0NCCGZymUJUFCunYImYRU7VmIAX3ABTQazNcv2huEEeZMTcvEvk3NChluUh1lPJ/mi5x0G2Cu1FpGfE1/+r cardno:000610168203"
            ];
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
