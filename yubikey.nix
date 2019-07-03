{ config, pkgs, lib, ... }:

{
	hardware = {
		u2f = {
			enable = true;
		};
	};
    systemd.services.i3lock = {
      enable = true;
      description = "i3lock";
      environment= { DISPLAY = ":0"; };
      serviceConfig = {
        User = "xadet";
        Type = "forking";
        ExecStart = "${pkgs.i3lock}/bin/i3lock -n";
      };
      wantedBy = [ "default.target" ];
    };
	services = {
        udev = {
            packages = with pkgs; [ yubikey-personalization ];
            extraRules = ''
              ACTION=="remove", ENV{KEY}=="?*", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", ENV{DISPLAY}=":0.0", ENV{XAUTHORITY}="/home/xadet/.Xauthority", RUN+="${pkgs.bash}/bin/bash -c 'systemctl --no-block start i3lock'"
      '';
        };
		pcscd = {
			enable = true;
		};
	};
    security = {
      pam = {
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
		gnupg = {
			agent = {
				enable = true;
				enableSSHSupport = true;
			};
		};
	};
	environment = {
		shellInit = ''
  export GPG_TTY="$(tty)"
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
		'';
	};
}
