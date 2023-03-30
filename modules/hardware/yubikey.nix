{ config, pkgs, lib, ... }:

{
  config = lib.mkMerge [
    {
      environment = {
        systemPackages = with pkgs; [
          yubico-piv-tool
          yubikey-personalization
          yubikey-personalization-gui
          yubioath-desktop
        ];
      };
      systemd.services.i3lock = {
        enable = true;
        description = "i3lock";
        environment = { DISPLAY = ":0"; };
        serviceConfig = {
          User = config.users.users.xadet.name;
          Type = "forking";
          ExecStart = "${pkgs.i3lock}/bin/i3lock -i ${config.users.users.xadet.home}/.background-image";
        };
        wantedBy = [ "default.target" ];
      };
      services = {
        pcscd = {
          enable = true;
        };
      };
      security = {
        pam = {
          enableSSHAgentAuth = true;
          u2f = {
            enable = true;
            control = "required";
            cue = true;
            authFile = ./u2f_keys;
          };
        };
      };
      programs = {
        ssh.startAgent = false;
      };
    }

    (lib.mkIf config.xadetComputer.yubikeyAutolock {
      services = {
        udev = {
          packages = with pkgs; [ yubikey-personalization libyubikey yubikey-personalization-gui ];
          extraRules = ''
            ACTION=="remove", ENV{KEY}=="?*", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", ENV{DISPLAY}=":0.0", ENV{XAUTHORITY}="${config.users.users.xadet.home}/.Xauthority", RUN+="${pkgs.bash}/bin/bash -c 'systemctl --no-block start i3lock'"
          '';
        };
      };
    })

  ];
}
