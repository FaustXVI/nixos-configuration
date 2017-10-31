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
			./user-packages.nix
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
		stateVersion = "17.09";
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
		pulseaudio = {
			enable = true;
			support32Bit = true;
			package = pkgs.pulseaudioFull;
		};
	};
	programs = {
		gnupg = {
			agent = {
				enable = true;
				enableSSHSupport = true;
			};
		};
	};
}
