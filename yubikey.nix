{ config, pkgs, lib, ... }:

{
	hardware = {
		u2f = {
			enable = true;
		};
	};
	services = {
        udev = {
            packages = with pkgs; [ yubikey-personalization ];
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
