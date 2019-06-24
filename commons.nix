# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./keyboard.nix
			./acpi.nix
			./network.nix
			./gui.nix
			./users.nix
			./system-packages.nix
			./virtualisation.nix
		];

	i18n = {
		consoleFont = "Lat2-Terminus16";
		consoleKeyMap = "fr";
		defaultLocale = "en_US.UTF-8";
	};

	time.timeZone = "Europe/Paris";

	system = {
		stateVersion = "19.03";
		autoUpgrade = {
			enable = true;
			dates = "13:00";
		};
	};

	nixpkgs = {
		config = {
			allowUnfree = true;
		};
	};

	hardware = {
		u2f = {
			enable = true;
		};
		pulseaudio = {
			enable = true;
			support32Bit = true;
			package = pkgs.pulseaudioFull;
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
