{ config, pkgs, lib, ... }:
let
  authFile = pkgs.writeText "u2f_file"
    ''
      xadet:KkTVzBCQuGE7sUgzx7oXyX4baaNkflLHR44gcNBwxDQN/+iPPsh1le3vnRvkEorZ9WGjhg/pk51FWp+5VmCeyQ==,Qkvu0bTmYByEKQ3eAzVgMIuqC8c7zJMfHQxgSlRu3KwPNEfK9MZbUrkApTBGwjDI8RzFtjAMZOh9rLAh16Bp7Q==,es256,+presence:z+fF70trV02I3MhsfkgWfkA9dMAmtnS6ccO5giEHyr+ORo7QVyMFNZO2YbukcCQ92rw981UydBk4/XY9dQB2Nw==,8+8uOvWSsYt6/xP0+ibieKnH75FNg50nWBpwU7auC4kfItxg42BFvKrhXS2zLQ1Jxs/eQefgLqgzAKUgPysO2w==,es256,+presence:nNbXVTSNX2tZBTzvpAlOQP7ahfvTaFliRWDSSDrBkLHf+JbMEs7Xh5U6Z0+vcAi6MRL25u36HcpJyL1AjhnitQ==,CVAhZuzHEUJ9irYDM4wfHKMz+OXiV7nXTQR3rdX3b/xvDIB9KfNF4R3CeJWcKul1Y2mShtpsEldFVFUJhSFJ/g==,es256,+presence
    '';
in
{
  config = {
    hardware.gpgSmartcards.enable = true;
    environment = {
      systemPackages = with pkgs; [
        yubico-piv-tool
        yubioath-flutter
      ];
    };
    systemd.services.auto-lock = {
      enable = true;
      description = "Lock screen";
      serviceConfig = {
        Type = "oneshot";
        User = config.users.users.xadet.name;
        Environment = [
        "XDG_RUNTIME_DIR=/run/user/${builtins.toString config.users.users.xadet.uid}"
        "WAYLAND_DISPLAY=wayland-1"
        ];
        ExecStart = ''${pkgs.lib.getExe pkgs.swaylock} '';
      };
    };
    services = {
      pcscd = {
        enable = true;
      };
    };
    security = {
      pam = {
        services = {
          login.u2fAuth = true;
          sudo.rssh = true;
        };
        rssh = {
          enable = true;
        };
        sshAgentAuth = {
          enable = lib.mkForce false;
        };
        u2f = {
          enable = true;
          control = "required";
          settings = {
            authfile = authFile;
            cue = true;
          };
        };
      };
    };
    programs = {
      ssh.startAgent = false;
    };
    services = {
      udev = {
        packages = with pkgs; [ yubikey-personalization libyubikey ];
        extraRules = ''
          ACTION=="remove", ENV{KEY}=="?*", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", RUN+="${pkgs.bash}/bin/bash -c 'systemctl --no-block start auto-lock'"
        '';
      };
    };

    virtualisation.vmVariant = {
      systemd.services.auto-lock = {
        enable = pkgs.lib.mkForce false;
      };

      security = {
        pam = {
          services.login.u2fAuth = pkgs.lib.mkForce false;
          u2f = {
            enable = pkgs.lib.mkForce false;
          };
        };
      };
    };

  };
}
