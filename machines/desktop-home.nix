# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			../commons.nix
			../gaming.nix
		];


	boot = {
		loader = {
			grub = {
				enable = true;
				useOSProber = true;
				device = "nodev";
				efiSupport = true;
			};
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
			drivers = [ pkgs.hplip ];
		};
		xserver = {
			videoDrivers = [ "nvidia" ];
			displayManager = {
				sessionCommands = ''
					#xrandr --output HDMI-0 --off --output DP-3 --mode 1920x1080 --output DP-4 --mode 2560x1080 --right-of DP-3 --primary &&
					#xrandr --output DP-1 --mode 1920x1080 --same-as DP-3 &
					${pkgs.pasystray}/bin/pasystray &
'';
			};
		};
	};

}
