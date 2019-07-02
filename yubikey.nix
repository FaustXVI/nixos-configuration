{ config, pkgs, lib, ... }:

{
	hardware = {
		u2f = {
			enable = true;
		};
	};
	services = {
		pcscd = {
			enable = true;
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
