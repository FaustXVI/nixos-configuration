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
			grub = {
				enable = true;
				version = 2;
				device = "/dev/sdb"; # or "nodev" for efi only
					extraEntries = ''
					menuentry "Windows 7" {
						insmod ntfs
						search --no-floppy --fs-uuid --set EE62F05562F023CD
						chainloader +1
					}
				'';
			};
		};
	};

	services = {
		xserver = {
			enable = true;
			monitorSection = ''
				Modeline "2560x1080_40.00"  147.25  2560 2680 2944 3328  1080 1083 1093 1108 -hsync +vsync
				Option "PreferredMode" "2560x1080_40.00"
				'';
		};
	};


}
