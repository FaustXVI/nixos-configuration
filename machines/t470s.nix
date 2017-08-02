# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			../commons.nix
		];

	boot = {
		loader = {
			systemd-boot = {
				enable = true;
			};
			efi = {
				canTouchEfiVariables = true; 
			};
		};
	};
	services = {
		printing = {
			enable = true;
			drivers = [ pkgs.gutenprint ];
		};
		xserver = {
			dpi = 150;
			displayManager = {
				sessionCommands = ''
					${pkgs.pasystray}/bin/pasystray &
'';
			};
		};
	};

}
